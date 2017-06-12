class CountInput extends React.Component {
    constructor(props) {
        super();
        this.invoiceId = props.invoiceId;
        this.flatIndex = props.flatIndex;
        this.meterIndex = props.meterIndex;
        this.countIndex = props.countIndex;
        this.count = props.count || {};
        this.state = {
            [this.getInputName('date')]: this.count.date || '',
            [this.getInputName('amount')]: this.count.amount || ''
        }
    }

    getInputName(field) {
        return `invoice[flats_attributes][${this.flatIndex}][meters_attributes][${this.meterIndex}][counts_attributes][${this.countIndex}][${field}]`;
    }

    handleInputChange(event) {
        const name = event.target.name;
        this.setState({
            [name]: event.target.value
        });
    }

    render() {
        return (
            <div className="count-inputs">
                <input id="" className="form-control" placeholder="Datum" value={this.state[this.getInputName('date')]} type="date"
                       name={this.getInputName('date')} onChange={(e) => {this.handleInputChange(e)}} />
                <input className="form-control" placeholder="Messwert" value={this.state[this.getInputName('amount')]} type="text"
                       name={this.getInputName('amount')} onChange={(e) => {this.handleInputChange(e)}} />
                <input type="hidden" name={this.getInputName('invoice_id')} value={this.invoiceId} />
            </div>
        );
    }
}

CountInput.PropTypes = {
    invoiceId: React.PropTypes.number,
    flatIndex: React.PropTypes.number,
    meterIndex: React.PropTypes.number,
    countIndex: React.PropTypes.number,
    count: React.PropTypes.object
}