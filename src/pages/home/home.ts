import { Component } from '@angular/core';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {
  public raisedHand: boolean = false;

  constructor() {}

  raiseHand() {
    this.raisedHand = !this.raisedHand;
  }

}
