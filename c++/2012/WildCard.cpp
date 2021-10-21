/*
 * WildCard.cpp
 *
 *  Created on: Feb 6, 2018
 *      Author: kevinw
 */

#include "WildCard.h"
#include "Player.h"
#include <sstream>

WildCard::WildCard():Card(color,POINT_WILDCARD){
	this->color=Color::meta;
};

WildCard::~WildCard(){};

void WildCard::serialize(ostream& os) const {
	if(this->color==Color::meta){
			os<<"WC";
	}if(this->color==Color::red){
			os<<"Rw";
	}if(this->color==Color::yellow){
			os<<"Yw";
	}if(this->color==Color::blue){
			os<<"Bw";
	}if(this->color==Color::green){
			os<<"Gw";
	}

}

bool WildCard::operator^(const Card& t) const{
	if(this->Card::operator ^(t)){
			return true;
	}
	return false;
}

void WildCard::castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile){
	this->color=currentPlayer->chooseColor();

}

void WildCard::init(){
	this->color=Color::meta;
};
