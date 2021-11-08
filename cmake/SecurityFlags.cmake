include(CheckCCompilerFlag)

if (CMAKE_C_COMPILER_ID MATCHES ".*Clang")
    # This rule applies to both "Clang" and "AppleClang".
elseif (CMAKE_C_COMPILER_ID STREQUAL "GNU")
    check_c_compiler_flag("-Werror -fstack-protector-all" HAVE_STACK_PROTECTOR_ALL)

    add_compile_options (-Wall -Wextra -Werror)
    add_compile_options (-Wformat -Wformat-nonliteral -Wformat-security)
    #add_compile_options (-Wshadow)
    #add_compile_options (-Wcast-qual)
    add_compile_options (-Wmissing-prototypes)
    add_compile_options (-Wbad-function-cast)
    add_compile_options (-Wno-implicit-fallthrough)
    #add_compile_options (-Wwrite-strings)
    add_compile_options (-pedantic)

	if(HAVE_STACK_PROTECTOR_ALL)
		add_compile_options(-fstack-protector-all)
	endif()
    add_compile_options (-Wl,-z,relro,-z,now)
    add_compile_options (-Wl,-z,noexecstack)
    set(CMAKE_POSITION_INDEPENDENT_CODE ON) # explicitly enable flag for -fPIC and -fPIE
elseif (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
else ()
    message(WARNING "Security related flags cannot be set for unknown C compiler.")
endif ()