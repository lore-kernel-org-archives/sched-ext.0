Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AE45C0B;
	Tue,  7 Oct 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861444; cv=none; b=eWISgvb5A0dd7TQSEn8bu+UBeh8fFVMednHxgpgc6TKd81FEzZRC6CiQ3rTFImShw2dKfTDW5TC9g8et57CNiZFuhRB9uEDezehkJwFZqkxJGEL8Sy5OZkjoryvoRyHCkUoaLqA4E/Jr40SVB5oy4q8O9BMfhJpHzy9jKlNW4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861444; c=relaxed/simple;
	bh=5xGytO6juBOv1Tj/sEX8D6ZlkEiV9MjWdcOHgrhxEtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e78wDV3m3ruiv5MTbG3AfqWP6zCOsbeod1iygUTC/+NIUzjjWbDJko7UDDzWfMasZONsvRFHO0MFLqNiIGixvHAqccj1p9Q2MgIG0Qc7OrydM4B7EY+FEzaPBIxLvCyOO0RD8thd4BhHnwHQXEBNUN3e30ePe0Etwlp/TantQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfjAsFrt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfjAsFrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62905C4CEF1;
	Tue,  7 Oct 2025 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759861443;
	bh=5xGytO6juBOv1Tj/sEX8D6ZlkEiV9MjWdcOHgrhxEtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfjAsFrtsIxZw52zBGy/ODnatD86WpGLAFmKViM1sSZndHW04RR99+P7y2jlz3qCy
	 BENj7NMezdt5PAwqR6PczC/7Ey254vxxMrjyH/TO8JakQiuhQwo+sGN4/7/WpeKIwy
	 y2AJWr4vx10trZp+DHCXvJfg8tJ6Um8aM8/tSdtSqTRaNjs+wPt7b8lylBrtA4p6NP
	 MVdOXDndNw4Ypknfyc3sny23g4l1Vd6fD3TSKhNyQMouPkg2JUnDXDypPX5u3lq8MV
	 +NJ5F464HYJkpZf+N5Yi9HtpFguBypV471n8DavJvBiPKEbK22FSRp3bHXJVhSTFPj
	 WLhdytdl9o1XA==
Date: Tue, 7 Oct 2025 08:24:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 3/4] sched_ext: Wrap kfunc args in struct to prepare for
 aux__prog
Message-ID: <aOVawkmvLVI95Zvb@slm.duckdns.org>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-4-tj@kernel.org>
 <aOTh_PAGkX9y2Tsy@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOTh_PAGkX9y2Tsy@gpd4>

Hello,

On Tue, Oct 07, 2025 at 11:48:44AM +0200, Andrea Righi wrote:
> > +struct scx_bpf_dsq_insert_vtime_args {
> > +	/* @p can't be packed together as KF_RCU is not transitive */
> > +	u64			dsq_id;
> > +	u64			slice;
> > +	u64			vtime;
> > +	u64			enq_flags;
> > +};
> 
> With PATCH 2/4 introducing scx_bpf_task_set_slice() and
> scx_bpf_task_set_dsq_vtime(), would it be reasonable to use those to set
> these task properties and then completely get rid of these args in
> scx_bpf_dsq_insert[_vtime]()?

Maybe. However, the most common usage pattern is setting vtime and slice on
insertion, so I think it makes sense to have a shortcut interface for that.
Even if the overhead difference is negligible, it's nice to have a dedicated
interface for the most common use case.

Thanks.

-- 
tejun
