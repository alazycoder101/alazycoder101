/*
 * ReverseCard.h
 *
 *  Created on: Feb 2, 2018
 *      Author: kevinw
 */

#ifndef REVERSECARD_H_
#define REVERSECARD_H_

#include "Card.h"

using namespace std;



class ReverseCard: public Card
{
public:
	ReverseCard(Color);
	virtual ~ReverseCard();
	virtual bool operator^(const Card& t) const;
	virtual void serialize(ostream&) const;
	virtual void castEffect(Player*& currentPlayer, CardPile& drawPile, CardPile& discardPile);
	virtual void init();
};



#endif /* REVERSECARD_H_ */
