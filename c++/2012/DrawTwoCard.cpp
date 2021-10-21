/*
 * DrawTwoCard.cpp
 *
 *  Created on: Feb 5, 2018
 *      Author: kevinw
 */

#include "DrawTwoCard.h"
#include "Player.h"
#include <sstream>
DrawTwoCard::DrawTwoCard(Color):SkipCard(color){

}

DrawTwoCard::~DrawTwoCard(){}

void DrawTwoCard::castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile){
	currentPlayer=currentPlayer->getNextPlayer();
	currentPlayer->getNextPlayer()->drawCard(drawPile,discardPile,2);

};

bool DrawTwoCard::operator^(const Card& t) const{
		if(this->Card::operator ^(t)){
			return true;
		}
		stringstream s;
		s << t;
		string result = s.str();
		if (result =="R+" or result =="G+" or result =="Y+" or result=="B+"){
			return true;}
			return false;
}
void DrawTwoCard::serialize(ostream& os) const{
	if(this->color ==Color::red){
			os<<"R";
	}if(this->color==Color::yellow){
			os<<"Y";
	}if(this->color==Color::blue){
			os<<"B";
	}if(this->color==Color::green){
			os<<"G";
	}
	os<<"+";;
}
void DrawTwoCard::init(){}
