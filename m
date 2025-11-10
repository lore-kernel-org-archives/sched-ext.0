Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9F239573
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762941; cv=none; b=rx4B04k+d2KgVcufxE1MKaPw6WSjEyBR5uvmSsg7TWcUE8Qs1IWVMjNZvPUbjjFx+Tg5Qh5k8YRAo/loFC7LFM7IaanqNYxgbWy3W6oUjiUCYuL9nUk64lvLUsag9scGBaIGCGCflC/qazDtSOtpnNqrwf7ClJCMAHSuSMWpeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762941; c=relaxed/simple;
	bh=Zb4po9L6/4m3ZA+haT3yHwnGASiZPF3eOIm0Zr/Li9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyCglq/iFnQiLJwpKbod9GvnD91JHJ02N2x+x9847V4oyk9iB7RpGLLnltETuXKoWnQK06x5m1oFe3GpWu5F2Ec8CsffEk5E68y6p/X8KdEyE8wrn3PD9nwYnVf6AAMCPkT3RWOgBJpRhdGe8xbjv3tcCUnOdmpAaCg95YkN9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HrsvegF2; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HrsvegF2"
Date: Mon, 10 Nov 2025 09:22:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762762937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTneWZ1xf+nI05xpIfQpthayeGGvztVcOZh4ue9SoQE=;
	b=HrsvegF2W2uPUP2bzmVyuI4xM3efOFiVoh5ywFsYgNeaT44IZBBhDnD5Qn7uhSJjUIfkej
	m61MP/ciKaEVhKpuWKPRmVcbDIvb5rpwOJYtjMLvyOgzz2mEb4PM6X6AJPJ7WzJJzTr+f9
	0Sqq5XqGdxxszU9zo9dM9ASWFGdzgXI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] sched_ext: Make slice values tunable and use
 shorter slice in bypass mode
Message-ID: <aRGgtBUWV9VtKctq@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109183112.2412147-3-tj@kernel.org>
X-Migadu-Flow: FLOW_OUT

Hi Tejun,

On Sun, Nov 09, 2025 at 08:31:01AM -1000, Tejun Heo wrote:
...
> +	/*
> +	 * %SCX_SLICE_DFL is used to refill slices when the BPF scheduler misses
> +	 * to set the slice for a task that is selected for execution.
> +	 * %SCX_EV_REFILL_SLICE_DFL counts the number of times the default slice
> +	 * refill has been triggered.
> +	 *
> +	 * %SCX_SLICE_BYPASS is used as the slice for all tasks in the bypass
> +	 * mode. As mkaing forward progress for all tasks is the main goal of

Small typo: s/mkaing/making/

-Andrea

> +	 * the bypass mode, a shorter slice is used.
> +	 */
>  	SCX_SLICE_DFL		= 20 * 1000000,	/* 20ms */
> +	SCX_SLICE_BYPASS	=  5 * 1000000, /*  5ms */
>  	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
>  };
>  
