class Datatable extends React.Component {
    render() {
        return (
            <div className="table-responsive">
                <table className="table table-striped table-hover">
                    <thead>
                        {this.props.renderHeader()}
                    </thead>
                    <tbody>
                        {this.props.children}
                    </tbody>
                </table>
            </div>
        );
    }
}