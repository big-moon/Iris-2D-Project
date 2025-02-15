#include "IrisFont.h"

wstring IrisFont::defaultName = L"����";
int IrisFont::defaultSize = 20;
bool IrisFont::defaultBold = false;
bool IrisFont::defaultItalic = false;
bool IrisFont::defaultShadow = false;
IrisColor *IrisFont::defaultColor = new IrisColor(255, 255, 255, 255);

IrisFont::IrisFont(){
	this->italic = false;
	this->bold = false;
	this->color = false;
	this->name = L"����";
	this->shadow = false;
	this->size = 20;
}

void IrisFont::SetInitData(wstring name, int size){
	this->italic = IrisFont::defaultItalic;
	this->bold = IrisFont::bold;
	this->color = IrisFont::color;
	this->name = name;
	this->shadow = IrisFont::defaultShadow;
	this->size = size < 0 ? IrisFont::defaultSize : size;
}


IrisFont::IrisFont(wstring name, int size)
{
	this->italic = IrisFont::defaultItalic;
	this->bold = IrisFont::bold;
	this->color = IrisFont::color;
	this->name = name;
	this->shadow = IrisFont::defaultShadow;
	this->size = size < 0 ? IrisFont::defaultSize : size;
}

int CALLBACK IrisFont::EnumFontsProc(LOGFONT* lplf, TEXTMETRIC* lptm, DWORD dwType, LPARAM lpData){
	return 1;
}

bool IrisFont::Existed(wstring name){
	LPARAM  lp = 0;
	lp = EnumFonts(NULL, name.c_str(), (FONTENUMPROC)EnumFontsProc, lp);

	if (lp == 0){
		return false;
	}
	else {
		return true;
	}
}

IrisFont::~IrisFont(void)
{
}
