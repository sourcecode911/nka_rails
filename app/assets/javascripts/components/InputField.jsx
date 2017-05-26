class InputField extends React.Component {
    constructor(props) {
        super();
        this.label = props.label;
        this.model = props.model;
        this.attr = props.attr;
        this.unit = props.unit;
        this.state = {
            value: (props.value ? props.value : '')
        }
    }

    handleChange(event) {
        this.setState({
            value: event.target.value
        });
    }

    render() {
        return (
        <div className="form-group">
            <label htmlFor={this.model + '_' + this.attr} className="col-sm-2 control-label">{this.label}</label>
            <div className="input-group col-sm-4">
                <input type="text" id={`${this.model}_${this.attr}`} name={`${this.model}[${this.attr}]`}
                       value={this.state.value} className="form-control" onChange={(e) => this.handleChange(e)} />
                <span className="input-group-addon">{this.unit}</span>
            </div>
        </div>);
    }
}

PriceInput.PropTypes = {
    label: React.PropTypes.string,
    model: React.PropTypes.string,
    attr: React.PropTypes.string,
    unit: React.PropTypes.string
}
