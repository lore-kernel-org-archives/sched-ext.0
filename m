Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420B1EA7C6;
	Tue,  7 Oct 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860570; cv=none; b=ReZKffUUzBE5SVBoLkQpXE8QBB23ubKvohxwa0Ik31QgUgKucyCSmwsrcikqFSlYx1s/VljYf46AhAIGJysN7Pz7lQYEZs4OnGfz02RKZatnI6X7JH0RPFucuqwNd877hQcTPTdk70flHW4GW+Y6a8TuGs6sI7YRz6EGHxEx5m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860570; c=relaxed/simple;
	bh=deE//NdoX9/8em4C1+SwrlezMYdEEANgCW3lGBN0V4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8TApONcM1nG/IUnqJFpespDHN1YnMS8GysUm0OAqztM07u/Nbp21MTVF74wh1x3arpdl6sQFdbzjAYzruy9kNe6nU8EEQTFx2rjlUkRd+KbXyUy5UyCzPduw3d2UgU0ZV9U89Mg9TRT6WegH1aTF9dW0n4O1cRxR8sJ9rTAkOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+6eUsNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+6eUsNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC8C4CEF1;
	Tue,  7 Oct 2025 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759860570;
	bh=deE//NdoX9/8em4C1+SwrlezMYdEEANgCW3lGBN0V4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+6eUsNWUjJWTNW6W4mc5G3seATASIaFheqySMSbzChUZclAGT37FuGyFhGHUjkjS
	 JHzy3J68NFnCZTN8ltc6fDx+OBZ3eFN0zgz8VagwWMmxQwXDkMG++L9Ds3HSeHfBvf
	 0R1W+Dw3v7XEFJ/UGFVIKi/dsVPQafmEE21GMCuTu5nk7oYgcZ4H+A4YmRkXhBjNPF
	 zY7Fe9/XLtCXsJdkeTDmmcgty65ityqXRshWa8bb5GtAerdxJLmiZjv8xicoXcFWzY
	 sEY5SJXrV+ycufKCYcK+RukPYKhdcOLAd3c9/dBRj5VozK2GrTZK02IGuzVekyl+l+
	 DGDGFOXecUfDw==
Date: Tue, 7 Oct 2025 08:09:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/4] sched_ext: Add scx_bpf_task_set_slice() and
 scx_bpf_task_set_dsq_vtime()
Message-ID: <aOVXWeBkCO7rUDvX@slm.duckdns.org>
References: <20251007015147.2496026-1-tj@kernel.org>
 <20251007015147.2496026-3-tj@kernel.org>
 <aOTewKyj8-0ub-23@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOTewKyj8-0ub-23@gpd4>

On Tue, Oct 07, 2025 at 11:34:56AM +0200, Andrea Righi wrote:
> Hi Tejun,
> 
> On Mon, Oct 06, 2025 at 03:51:45PM -1000, Tejun Heo wrote:
> > With the planned hierarchical scheduler support, sub-schedulers will need to
> > be verified for authority before being allowed to modify task->scx.slice and
> > task->scx.dsq_vtime. Add scx_bpf_task_set_slice() and
> > scx_bpf_task_set_dsq_vtime() which will perform the necessary permission
> > checks.
> > 
> > Root schedulers can still directly write to these fields, so this doesn't
> > affect existing schedulers.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> 
> Maybe provide __COMPAT_scx_bpf_task_set_slice() and
> __COMPAT_scx_bpf_task_set_dsq_vtime(), but we can do this later.

Ah, right. Will do.

Thanks.

-- 
tejun
