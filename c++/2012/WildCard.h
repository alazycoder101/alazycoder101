/*
 * WildCard.h
 *
 *  Created on: Feb 6, 2018
 *      Author: kevinw
 */

#ifndef WILDCARD_H_
#define WILDCARD_H_
#include "Card.h"

using namespace std;



class WildCard: public Card
{
public:

	WildCard();
	virtual ~WildCard();
	virtual void serialize(ostream&) const;
	virtual void castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile);
	virtual void init();
	virtual bool operator^(const Card& t) const;
};


#endif /* WILDCARD_H_ */
