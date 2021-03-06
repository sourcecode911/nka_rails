class AddCount extends React.Component {
    constructor(props) {
        super();
        this.invoiceId = props.invoiceId;
        this.flatIndex = props.flatIndex;
        this.meterIndex = props.meterIndex;
        this.countIndex = props.countIndex;
        this.defaultDate = props.defaultDate;
        this.state = {
            numCounts: 0
        }
    }

    addCount() {
        let numCounts = this.state.numCounts + 1;
        this.setState({numCounts: numCounts});
    }

    render() {
        const counts = [];

        for (var i = 0; i < this.state.numCounts; i += 1) {
            counts.push(<CountInput key={i} flatIndex={this.flatIndex} meterIndex={this.meterIndex}
                                    countIndex={(this.countIndex - 1) + this.state.numCounts} invoiceId={this.invoiceId} defaultDate={this.defaultDate} />);
        }

        return (
            <div className="addCount">
                {counts}
                <div className="addCountButton">
                    <button type="button" className="btn btn-default" onClick={this.addCount.bind(this)}>
                        <span className="glyphicon glyphicon-plus" aria-hidden="true"/>
                    </button>
                </div>
            </div>
        );
    }
}

AddCount.PropTypes = {
    invoiceId: React.PropTypes.number,
    flatIndex: React.PropTypes.number,
    meterIndex: React.PropTypes.number,
    countIndex: React.PropTypes.number,
    defaultDate: React.PropTypes.number
}