/*
 * ReverseCard.cpp
 *
 *  Created on: Feb 2, 2018
 *      Author: kevinw
 */

#include "ReverseCard.h"
#include "Player.h"
#include <sstream>

ReverseCard::ReverseCard(Color color):Card(color,POINT_REVERSECARD){

}

ReverseCard::~ReverseCard(){};

void ReverseCard::serialize(ostream& os) const {
	if(this->color==Color::red){
		os<<"R";
	}if(this->color==Color::yellow){
		os<<"Y";
	}if(this->color==Color::blue){
		os<<"B";
	}if(this->color==Color::green){
		os<<"G";
	}
	os<<"r";
}
bool ReverseCard::operator^(const Card& t) const{
	if(this->Card::operator ^(t)){
				return true;
			}
		stringstream s;
		s << t;
		string result = s.str();
		if (result =="Rr" or result =="Gr" or result =="Yr" or result=="Br")
			return true;

		return false;

	}

void ReverseCard::castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile){
	int a=0;
	Player* k=currentPlayer;
	Player* j=currentPlayer->nextPlayer;
	Player* h=currentPlayer;
	for(Player* p=currentPlayer;p->getNextPlayer()!=currentPlayer;p=p->getNextPlayer()){
	a++;}
	for(int i=0;i<a+1;i++)
		{
			h=j->nextPlayer;
			j->nextPlayer=k;
			k=j;
			j=h;
		}
}


void ReverseCard::init(){};
