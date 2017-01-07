import { Injectable } from '@angular/core';
import { AngularFire, FirebaseListObservable, FirebaseObjectObservable } from 'angularfire2';
import { AlertController } from 'ionic-angular';

/*
  Generated class for the Initializer provider.

  See https://angular.io/docs/ts/latest/guide/dependency-injection.html
  for more info on providers and Angular 2 DI.
*/
@Injectable()
export class Room {
  private room: FirebaseListObservable<any>;
  private ref;
  private user;

  constructor(
    private alertCtrl: AlertController,
    private af: AngularFire
  ) {}

  raiseHand(status) {
    this.ref.update({
      status,
      user: this.user,
      lastUpdate: Date.now()
    });
  }

  get list() {
    return this.room;
  }

  init() : Promise<any> {
    return new Promise((resolve, reject) => {
      const alert = this.alertCtrl.create({
        title: 'Bem vindo',
        inputs: [
          {
            name: 'room',
            placeholder: 'Sala'
          },
          {
            name: 'user',
            placeholder: 'Usuário'
          }
        ],
        buttons: [
          {
            text: 'Entrar',
            handler: props => {
              this.user = props.user;
              this.room = this.af.database.list(`/rooms/${props.room}`);

              this.room.push({
                user: this.user,
                status: false,
                lastUpdate: Date.now()
              })
              .then(_ => {
                this.ref = _;

                resolve(this.ref);
              });
            }
          }
        ]
      });
      alert.present();
    });
  }
}
