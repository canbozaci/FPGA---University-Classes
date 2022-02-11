SRC_FILES := $(wildcard ./*.c*)
OBJ_FILES := $(patsubst ./%.c*,./%.o,$(SRC_FILES))
TARGET := main.exe
OUT_FLAG := -o 
COMPILE_FLAG := -c

all: $(TARGET)

$(TARGET): $(OBJ_FILES)
	g++ $(OUT_FLAG) $@ $^

./%.o:./%.c*
	g++  $(COMPILE_FLAG) $(OUT_FLAG) $@ $<

run: $(TARGET)
	$(info **************************************)
	$(info **************************************)
	$(info **************************************)
	$(info **************************************)
	.\$(TARGET)

clean:
	rm -rf *.exe *.o