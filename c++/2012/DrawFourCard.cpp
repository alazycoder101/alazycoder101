#include "DrawFourCard.h"
#include "Player.h"


DrawFourCard::DrawFourCard():WildCard(){
	this->color=Color::meta;

};

DrawFourCard::~DrawFourCard(){};

bool DrawFourCard::operator^(const Card& t) const {
	if(this->Card::operator ^(t)){
		return true;
	}
	return false;
}

void DrawFourCard::castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile){
	this->color=currentPlayer->chooseColor();
	bool fail =false;
	if(currentPlayer->getNextPlayer()->appealDrawFour())
	{
		for(int i=0;i<currentPlayer->getSize();i++){
			if((*(discardPile.getTopCard()))^*(currentPlayer->getCard(i)))
			{
				currentPlayer=currentPlayer->getNextPlayer();
				currentPlayer->drawCard(drawPile,discardPile,6);
				fail=true;
				break;}
		}
		if(!fail){
		currentPlayer->drawCard(drawPile,discardPile,4);}
	}
	else
		{
		currentPlayer=currentPlayer->getNextPlayer();
		currentPlayer->drawCard(drawPile,discardPile,4);}

	}


void DrawFourCard::init(){
	this->color=Color::meta;
};
void DrawFourCard::serialize(ostream& os) const{
	if(this->color==Color::meta){
				os<<"+4";
	}if(this->color==Color::red){
				os<<"4R";
	}if(this->color==Color::yellow){
				os<<"4Y";
	}if(this->color==Color::blue){
				os<<"4B";
	}if(this->color==Color::green){
				os<<"4G";
	};
}
