/*
 * SkipCard.h
 *
 *  Created on: Feb 2, 2018
 *      Author: kevinw
 */

#ifndef SKIPCARD_H_
#define SKIPCARD_H_

#include <string>
#include <iostream>

#include "Card.h"

using namespace std;


class SkipCard : public Card
{
public:
	SkipCard(Color);
	virtual ~SkipCard();
	virtual bool operator^(const Card& t) const;
	virtual void serialize(ostream&) const;
	virtual void castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile);
	virtual void init();

};
#endif /* SKIPCARD_H_ */
