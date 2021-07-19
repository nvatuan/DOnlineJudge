import zipfile as zf

class TestZipHandler:
	def __init__(self, path):
		self.zippath = path
		self.archive = zf.ZipFile(path) # raise if archive cannot be read
		self.archive.testzip() # raise on bad archive
		self.validate()

	def validate(self):
		try:
			infiles = set()
			outfiles = set()
			for fpath in self.archive.namelist():
				if zf.Path(self.archive, fpath).is_file():
					stripfpath = fpath.split('/')[-1]
					if stripfpath.endswith('.in'):
						if stripfpath in infiles:
							raise ValueError("Duplicate .in files with the same name")
						else:
							infiles.add(stripfpath[:-3])
					elif stripfpath.endswith('.out'):
						if stripfpath in outfiles:
							raise ValueError("Duplicate .in files with the same name")
						else:
							outfiles.add(stripfpath[:-4])
			if infiles != outfiles:
				raise ValueError("List of .in file mismatches List of .out file")
			if len(infiles) == 0:
				raise ValueError("No .in/.out files are found")
			return True
		except:
			raise
			## TODO Exception handling for TestZipValidator
	
	def get_testdata(self):
		inmap = {}
		outmap = {}

		for fpath in self.archive.namelist():
			if zf.Path(self.archive, fpath).is_file():
				stripfpath = fpath.split('/')[-1]
				if stripfpath.endswith('.in'):
					inmap[stripfpath] = self.archive.read(fpath) 
				elif stripfpath.endswith('.out'):
					outmap[stripfpath] = self.archive.read(fpath) 
		
		#print('Inmap', inmap)
		#print('Outmap', outmap)

		tests = []
		for inname in inmap.keys():
			outname = inname[:-3]+'.out'
			tests.append((inmap[inname].decode(), outmap[outname].decode()))
		#print('Tests', tests)
		return tests


		
