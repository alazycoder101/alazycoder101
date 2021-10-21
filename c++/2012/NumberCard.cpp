/*
 * NumberCard.cpp
 *
 *  Created on: Jan 29, 2018
 *      Author: kevinw
 */

#include "NumberCard.h"

NumberCard::NumberCard(const int point, Color color):Card(color,point){
}

NumberCard::~NumberCard(){};

void NumberCard::serialize(ostream& os) const {
	if(this->color==Color::red){
		os<<"R";
	}if(this->color==Color::yellow){
		os<<"Y";
	}if(this->color==Color::blue){
		os<<"B";
	}if(this->color==Color::green){
		os<<"G";
	}
	os<<this->getPoint();
}
bool NumberCard::operator ^(const Card& t) const {
	if(this->Card::operator ^(t)){
				return true;}
	if (t.getPoint()==this->getPoint()){
		return true;}
	return false;

}
void NumberCard::castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile){

}

void NumberCard::init(){};
