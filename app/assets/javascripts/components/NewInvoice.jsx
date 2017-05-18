class NewInvoice extends React.Component {
    constructor(props) {
        super();
        this.years = props.years;
    }

    renderSelect() {
        return this.years.map((year) => {
            return(<option key={year} value={year}>{year}</option>);
        });
    }

    createInvoice() {
        let invoice = {year: document.getElementById('yearInput').value};
        httpPost('/invoices', {invoice: invoice}, this.refreshInvoices.bind(this));
    }

    refreshInvoices(resp) {
        httpGet('/invoices', function(resp) {

        });
    }

    render() {
        return (
            <form className="form-inline">
                <div className="form-group">
                    <label htmlFor="yearInput">Jahr: </label>
                    <select id="yearInput" className="form-control" name="yearInput">
                        {this.renderSelect()}
                    </select>
                </div>
                <button type="button" className="btn btn-primary" aria-label="Erstellen" onClick={() => {this.createInvoice()}}>
                    <span className="glyphicon glyphicon-plus" aria-hidden="true" /> Neue Abrechnung erstellen
                </button>
            </form>
        );
    }
}