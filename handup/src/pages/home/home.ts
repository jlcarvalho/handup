import { Component } from '@angular/core';

import sortBy from 'lodash/fp/sortBy';

import { Room } from '../../providers/room';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
  public hands = [];
  public raisedHand: boolean = false;

  constructor(
    private roomService: Room
  ) {}

  ionViewDidEnter() {
    this.roomService.list.subscribe(hands => {
      this.hands = sortBy(h => h.lastUpdate / (h.status ? 10 : 1))(hands);
    })
  }

  raiseHand() {
    this.raisedHand = !this.raisedHand;

    this.roomService.raiseHand(this.raisedHand);
  }

}
