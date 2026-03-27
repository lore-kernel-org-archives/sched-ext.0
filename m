Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B91D9346;
	Fri, 27 Mar 2026 00:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774572172; cv=none; b=txIr553eCnk+TSLSh2BYM8ekFQSI46j98dgjnBmJnLxNyQSRW0TZgb0uas+qHm4IW3ZQrjniANT/RA7YWpRQbewQxtbh8fmY5BFBH3Yduub1Z0Lwo3hO5RA3Zmvnw5NZ2/Hxi/+VaptW90EPn/d0F1W24wuvP/qMe05fE+vMB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774572172; c=relaxed/simple;
	bh=ICX7nolKyIissU91JvBzXaiH1tJotKc62H56iH/9tIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efz5pr/LytZ27YzAJRIWN6Av7tthLTCPFCprlrP2oY7cYnw5y8R7tAWnz+gToW5O1jsYl+57rxlILk6x03vWixvVUWr95u83hAuZgsViaTb2VODMs+grb7MPaPwI0Ch4CXLbpt1X1h6wssEDcNrS1CNtxcKFw2clfDzGRZejjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXPtVI7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXPtVI7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8B2C116C6;
	Fri, 27 Mar 2026 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774572172;
	bh=ICX7nolKyIissU91JvBzXaiH1tJotKc62H56iH/9tIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EXPtVI7YN9YgYc9Ih6uds2iraLmAJbyFteSaksjclRoNEZTyZLTkSTMSDB+d0gKtA
	 GIMWRMtyfnb/S0TNwcsHGa3iqjsI2Idkwlomv5+evq8sLQ/mWdGJzTgh9molwzT7+L
	 UsWEA6q4aBdaRnT/eRN+St4bp2q3GnamI/cZaEhADOWIwVbOQW3/7pefws5e/KCWUy
	 LhTJRMcJVs2l0UR5gbkK9EYg8CWjU88L4aRgdnt/rC1uKazmDcGo/iBgbXSK/H7q/3
	 jm9zvpW6YBjC8oABg6p8I3rzFOZmAgPgmCyg1ZNriRwt3mblEN7lh13uFDZWh6LDPO
	 CZdvfaLeb9SvQ==
Date: Thu, 26 Mar 2026 14:42:50 -1000
From: Tejun Heo <tj@kernel.org>
To: zhidao su <soolaugust@gmail.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	peterz@infradead.org, mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: Re: [PATCH 1/4] tools/sched_ext: compat.bpf.h: fix
 scx_bpf_dsq_reenq___compat signature
Message-ID: <acXSilgub4NvWHXj@slm.duckdns.org>
References: <20260326204238.3755737-1-suzhidao@xiaomi.com>
 <20260326204238.3755737-2-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326204238.3755737-2-suzhidao@xiaomi.com>

On Fri, Mar 27, 2026 at 04:42:35AM +0800, zhidao su wrote:
> scx_bpf_dsq_reenq() is declared with KF_IMPLICIT_ARGS in the kernel BTF,
> which means the BPF verifier automatically injects the
> struct bpf_prog_aux *aux parameter.  The BPF-side weak symbol declaration
> must NOT include the implicit parameter.
> 
> The previous declaration included an explicit aux__prog parameter, which
> caused BPF programs calling scx_bpf_dsq_reenq() through the compat macro
> to fail verification on kernels where the kfunc is available.

Did this actually cause verification failure tho? If BPF isn't ignoring the
implicit arg, it should have just failed ksym_exists test and then fell back
to the older interface or trigger scx_bpf_error().

It's rather obvious that most of your patches are AI slob and I don't see
much value in the selftests that you added either. I'll just revert your
previous patches. Please carefully consider whether what you're sending
actually contributes anything practical and carefully verify the code
changes and description before sending them. These frivolous and plausible
sounding but not actually correct patches are taking bandwidth without
actually improving anything. I'll likely ignore your submissions from now on
unless the trajectory changes substantially.

Thanks.

-- 
tejun
