/*
 * Player.cpp
 *
 *  Created on: Jan 29, 2018
 *      Author: kevinw
 */

#include "Player.h"

ostream& operator<<(ostream& os, const Player& h) {
	os << h.name << ":";
	for (int i = 0; i < h.getSize(); i++) {
		os << *h.getCard(i) << " ";
	}
	return os;
}

Player::Player(string name,Player* previous){
	this->name=name;

	if(previous){
	this->nextPlayer=previous->nextPlayer;
	previous->nextPlayer=this;
	}
	else this->nextPlayer=this;
}
void Player::drawCard(CardPile& drawPile, CardPile& discardPile, int number_of_cards){
	if(drawPile.getSize()+discardPile.getSize()>number_of_cards){
		if(drawPile.getSize()>number_of_cards){
			for(int i=0;i<number_of_cards;i++){
				(*this)+=drawPile.removeTopCard();}
		}else{
			int a=drawPile.getSize();
			for(int i=0;i<drawPile.getSize();i++){
				(*this)+=drawPile.removeTopCard();}
			for(int i=0;i<discardPile.getSize()-1;i++){
				drawPile+=discardPile.removeCard(discardPile.getSize()-2);
			}
			drawPile.shuffle();
			for(int i=0;i<number_of_cards-a;i++){
				(*this)+=drawPile.removeCard(discardPile.getSize()-1);}
		}

	}
	else{
		for(int i=0;i<drawPile.getSize();i++){
			(*this)+=drawPile.removeTopCard();}
		for(int i=0;i<discardPile.getSize()-1;i++){
			drawPile+=discardPile.removeCard(discardPile.getSize()-2);
	}
		drawPile.shuffle();
		for(int i=0;i<drawPile.getSize();i++){
			(*this)+=drawPile.removeCard(discardPile.getSize()-1);}

	}
}
Card* Player::playCardAfter(const Card* topCard, int index){
	if(this->getCard(index)){
	if((*topCard)^(*(this->getCard(index)))){
		cout<<"1"<<endl;
		return this->removeCard(index);
	}
}	cout<<"2"<<endl;
	return nullptr;
}
int Player::getScore() const{
	int total=0;
	for(int i=0;i<this->getSize();i++){
		total+=this->getCard(i)->getPoint();
	}
	return total;
}


