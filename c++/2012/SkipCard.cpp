/*
 * SkipCard.cpp
 *
 *  Created on: Feb 2, 2018
 *      Author: kevinw
 */

#include "SkipCard.h"
#include "Player.h"
#include <sstream>

SkipCard::SkipCard(Color color):Card(color,POINT_SKIPCARD){
}

SkipCard::~SkipCard(){};

void SkipCard::serialize(ostream& os) const {
	if(this->color==Color::red){
		os<<"R";
	}if(this->color==Color::yellow){
		os<<"Y";
	}if(this->color==Color::blue){
		os<<"B";
	}if(this->color==Color::green){
		os<<"G";
	}
	os<<"s";
}

bool SkipCard::operator^(const Card& t) const{
	if(this->Card::operator ^(t)){
				return true;
			}
	stringstream s;
	s << t;
	string result = s.str();
	if (result =="Rs" or result =="Gs" or result =="Ys" or result=="Bs"){
		return true;}

		return false;

}

void SkipCard::castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile){
currentPlayer=currentPlayer->getNextPlayer();
}

void SkipCard::init(){};
