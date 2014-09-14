message("Configuring thirdparty package: libssh2")
set(libName "libssh2")
set(workDir "${thirdpartyDir}/${libName}")
set(unpackedDirName "libssh2-1.4.3")
set(libSourcesDir "${workDir}/${unpackedDirName}")
set(url "http://www.libssh2.org/download/libssh2-1.4.3.tar.gz")
set(md5sum "071004c60c5d6f90354ad1b701013a0b")
set(archiveFileName "libssh2-1.4.3.tar.gz")
set(installPrefix "${thirdpartyDir}/out")
set(libraryFileName libssh2.so.1)
set(libSSH2Installed "${installPrefix}/lib/${libraryFileName}")
if (NOT EXISTS "${workDir}/${archiveFileName}")
	Message("Downloading  http://files.pharo.org/vm/src/lib/${archiveFileName}")

	FILE(DOWNLOAD
		http://files.pharo.org/vm/src/lib/libssh2-1.4.3.tar.gz
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


add_custom_command(OUTPUT "${libSSH2Installed}"
	COMMAND ./configure --prefix='${installPrefix}' CFLAGS='-m32' LDFLAGS='-m32'
	DEPENDS "${unpackTarget}"
	COMMAND make
	COMMAND make install
	WORKING_DIRECTORY "${libSourcesDir}"
	COMMENT "Building ${libName}"
)

add_custom_command( OUTPUT "${externalModulesDir}/${libraryFileName}"
	COMMAND cp "${libSSH2Installed}" "${externalModulesDir}/${libraryFileName}"
	DEPENDS "${libSSH2Installed}"
	)

add_custom_target(${libName} 
	DEPENDS ${externalModulesDir}/${libraryFileName}
	)

