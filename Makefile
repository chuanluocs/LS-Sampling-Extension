COMPILER = g++
CFLAGS = -O3 -std=c++11 -static
# -fsanitize=address -fsanitize=leak

PRE_CFLAGS = ${CFLAGS} -c
TARGET = LS-Sampling

SRC_DIR = src

LIB_DIR = lib

BIN_DIR = bin

CADICAL = cadical

MERSENNE = mersenne
MERSENNE_TARGET = ${SRC_DIR}/${MERSENNE}.o
MERSENNE_CC_FILE = ${SRC_DIR}/${MERSENNE}.cc
MERSENNE_H_FILE = ${SRC_DIR}/${MERSENNE}.h
MERSENNE_SOURCE_FILES = ${MERSENNE_H_FILE} ${MERSENNE_CC_FILE}

PBOCCSATSOLVER = pboccsatsolver
PBOCCSATSOLVER_TARGET = ${SRC_DIR}/${PBOCCSATSOLVER}.o
PBOCCSATSOLVER_CPP_FILE = ${SRC_DIR}/${PBOCCSATSOLVER}.cpp
PBOCCSATSOLVER_H_FILE = ${SRC_DIR}/${PBOCCSATSOLVER}.h
PBOCCSATSOLVER_SOURCE_FILES = ${SOLVER_H_FILE} ${SOLVER_CPP_FILE}

SLSTESTCASESAMPLER = slstestcasesampler
SLSTESTCASESAMPLER_TARGET = ${SRC_DIR}/${SLSTESTCASESAMPLER}.o
SLSTESTCASESAMPLER_CPP_FILE = ${SRC_DIR}/${SLSTESTCASESAMPLER}.cpp
SLSTESTCASESAMPLER_H_FILE = ${SRC_DIR}/${SLSTESTCASESAMPLER}.h
SLSTESTCASESAMPLER_SOURCE_FILES = ${SLSTESTCASESAMPLER_H_FILE} ${SLSTESTCASESAMPLER_CPP_FILE}

TARGET_FILES =	${MERSENNE_TARGET} \
				${PBOCCSATSOLVER_TARGET} \
				${SLSTESTCASESAMPLER_TARGET} \
				
MAIN_SOURCE_FILE = ${SRC_DIR}/main.cpp


UPDATE = update
CLEAN = clean
CLEANUP = cleanup


all: ${TARGET_FILES} ${TARGET} ${UPDATE} ${CLEAN}

${MERSENNE_TARGET}: ${MERSENNE_SOURCE_FILES}
	${COMPILER} ${PRE_CFLAGS} ${MERSENNE_CC_FILE} -o ${MERSENNE_TARGET}

${PBOCCSATSOLVER_TARGET}: ${PBOCCSATSOLVER_SOURCE_FILES}
	${COMPILER} ${PRE_CFLAGS} ${PBOCCSATSOLVER_CPP_FILE} -o ${PBOCCSATSOLVER_TARGET}

${SLSTESTCASESAMPLER_TARGET}: ${SLSTESTCASESAMPLER_SOURCE_FILES}
	${COMPILER} ${PRE_CFLAGS} ${SLSTESTCASESAMPLER_CPP_FILE} -o ${SLSTESTCASESAMPLER_TARGET} -L ${LIB_DIR} -l${CADICAL} 

${TARGET}: ${MAIN_SOURCE_FILE} ${TARGET_FILES}
	${COMPILER} ${CFLAGS} ${MAIN_SOURCE_FILE} ${TARGET_FILES} -o ${TARGET} -L ${LIB_DIR} -l${CADICAL} 

${UPDATE}:
	chmod +x ${BIN_DIR}/*

${CLEAN}:
	rm -f *~
	rm -f ${SRC_DIR}/*.o
	rm -f ${SRC_DIR}/*~

${CLEANUP}: ${CLEAN}
	rm -f ${TARGET}
