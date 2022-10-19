import { LightningElement } from 'lwc';

export default class Lwcomponent extends LightningElement
{
    name='veeranjaneyulu';
    callme(event)
    {
        this.name='veernjaneyulu info';
    }
}