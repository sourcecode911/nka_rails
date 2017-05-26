class InputField extends React.Component {
    constructor(props) {
        super();
        this.label = props.label;
        this.model = props.model;
        this.attr = props.attr;
        this.unit = props.unit;
        this.width = props.width || 4;
        this.state = {
            value: (props.value ? props.value : '')
        }
    }

    handleChange(event) {
        this.setState({
            value: event.target.value
        });
    }

    renderUnit() {
        if(this.unit) {
            return (<span className="input-group-addon">{this.unit}</span>)
        } else {
            return null;
        }
    }

    render() {
        return (
        <div className="form-group">
            <label htmlFor={this.model + '_' + this.attr} className="col-sm-2 control-label">{this.label}</label>
            <div className={this.unit? 'input-group col-sm-' + this.width : 'col-sm-' + this.width}>
                <input type="text" id={`${this.model}_${this.attr}`} name={`${this.model}[${this.attr}]`}
                       value={this.state.value} className="form-control" onChange={(e) => this.handleChange(e)} />
                {this.renderUnit()}
            </div>
        </div>);
    }
}

InputField.PropTypes = {
    label: React.PropTypes.string,
    model: React.PropTypes.string,
    attr: React.PropTypes.string,
    unit: React.PropTypes.string,
    width: React.PropTypes.number
}
