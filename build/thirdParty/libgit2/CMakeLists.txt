message("Configuring thirdparty package: libgit2")
set(libName "libgit2")
set(workDir "${thirdpartyDir}/${libName}")
set(unpackedDirName "libgit2-0.20.0")
set(libSourcesDir "${workDir}/${unpackedDirName}")
set(url "http://github.com/libgit2/libgit2/archive/v0.20.0.tar.gz")
set(md5sum "e35f613a37e11354f34249f2faa68237")
set(archiveFileName "v0.20.0.tar.gz")
set(installPrefix "${thirdpartyDir}/out")
set(libraryFileName libgit2.so.0.20.0)
set(libGit2Installed "${installPrefix}/lib/${libraryFileName}")
if (NOT EXISTS "${workDir}/${archiveFileName}")
	Message("Downloading  http://files.pharo.org/vm/src/lib/${archiveFileName}")

	FILE(DOWNLOAD
		http://files.pharo.org/vm/src/lib/v0.20.0.tar.gz
	 	"${workDir}/${archiveFileName}"
		STATUS downloadStatus
		SHOW_PROGRESS
	)
	
	LIST(GET downloadStatus 0 downloadError)
	if (NOT downloadError EQUAL 0)
		Message("File is missing on file server (http://files.pharo.org/vm/src/lib/), downloading from official repository...")
		FILE(DOWNLOAD
			${url}
		 	"${workDir}/${archiveFileName}"
			STATUS downloadStatus
			SHOW_PROGRESS
			EXPECTED_MD5 ${md5sum}
		)
		LIST(GET downloadStatus 0 downloadError)
	endif ()
	if (NOT downloadError EQUAL 0)
		message(FATAL_ERROR "Cannot find/download the source file from:" ${url})
	endif ()
		
	
endif ()

set(unpackTarget "${libSourcesDir}/touch.cmake")
add_custom_command(OUTPUT "${unpackTarget}"
		COMMAND tar -xzf "${archiveFileName}" 
		COMMAND touch "${unpackTarget}"
		COMMENT "Unpacking ${libName} ... "
	)


add_custom_command(OUTPUT "${libGit2Installed}"
	COMMAND cmake -DCMAKE_INSTALL_PREFIX="${installPrefix}" CFLAGS='-m32' LDFLAGS='-m32' -DCMAKE_C_FLAGS='-m32' -DCMAKE_CXX_FLAGS='-m32' . 
	WORKING_DIRECTORY "${libSourcesDir}"
	DEPENDS "${unpackTarget}"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)

add_custom_command( OUTPUT "${externalModulesDir}/${libraryFileName}"
	COMMAND cp "${libGit2Installed}" "${externalModulesDir}/${libraryFileName}"
	DEPENDS "${libGit2Installed}"
	)

add_custom_target(${libName} 
	DEPENDS ${externalModulesDir}/${libraryFileName}
	)

