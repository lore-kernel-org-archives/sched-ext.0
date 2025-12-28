Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B8287506;
	Sun, 28 Dec 2025 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766965349; cv=none; b=T9laNVZfHaE9eOG8p8TRFbo4JKAJrnLaDbjSWz+DrsA50XJ6ENZwAyymvhJ+CUTLLDV9/hrb9bUHlDEG69Pc3Nz+HNBx+O2d7dUQkoFPgIUDMKVgzKZrCiPwCNqY+MkrHgnLYM7FI47IQfv0jHaEJ7EShiZKlLDryNkzDdOq22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766965349; c=relaxed/simple;
	bh=ZEOi4g7vBR31gIzyNckSRPyA69EO8iyIsigofNIMlHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJsYiNIaS+Ocsdc7UkHu29O+Kdp+O2jkpVxF+tC/8ROEsWSFiK7v0muwZLgoLp84okldgvVblbRHztcpJOEBhJzBwRBuMsn+Slhlr+Iq1I6Yp7dGnRyqUB4qLXBB7ir6Tfsk+SVj024xmVFao+S00cwhQI+fPlpNADYwk5p/C44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6dscK6H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6dscK6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08675C4CEFB;
	Sun, 28 Dec 2025 23:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766965349;
	bh=ZEOi4g7vBR31gIzyNckSRPyA69EO8iyIsigofNIMlHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6dscK6HXhGf6lVta/0Ufgy2gzpK6EU9h4gT4vGHi2CGfAIILrNVGGH3u3i962wPL
	 Z+uhiNV+MYdUttXJTaCF8/m54/9l68PxzaiOeYHjkaCPddcvWZ/Iw39+0LTWL7wDcz
	 DQi5pfcMDkfeErfgPCLsjO/P6VaPjXqhN7HRiG0TpDo7/+YYYKpfX4yxARH56EPHTj
	 6jE0wTh7KkBvOKOWoxl7zWDIs4CuL/2S8PfnSZcbAmzdytT+7nxkJLDr5H95FTyTiT
	 p55zjzzIPDZNvZywxXrhbpO4UvtUtBt734BNkAjVy8v2HWfX4mCx23Nl9RQ7MoEL1I
	 E36Buhpi1Gi7A==
Date: Sun, 28 Dec 2025 13:42:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aVHAZNbIJLLBHEXY@slm.duckdns.org>
References: <20251219224450.2537941-1-arighi@nvidia.com>
 <20251219224450.2537941-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219224450.2537941-2-arighi@nvidia.com>

Hello,

On Fri, Dec 19, 2025 at 11:43:14PM +0100, Andrea Righi wrote:
> +   Once ``ops.enqueue()`` is called, the task is considered "enqueued" and
> +   is owned by the BPF scheduler. Ownership is retained until the task is

Can we avoid using "ownership" for this? From user's POV, this is fine but
kernel side internally uses the word for different purposes - e.g. we say
the BPF side owns the task if the task's SCX_OPSS_QUEUED is set (ie. it's on
BPF data structure, not on a DSQ). Here, the ownership encompasses both
kernel-side and BPF-side queueing, so the term becomes rather confusing.
Maybe we can stick with "queued" or "enqueued"?

Thanks.

-- 
tejun
