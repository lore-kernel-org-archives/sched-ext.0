Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB42495AD5;
	Thu,  8 Oct 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482667; cv=none; b=IBUJvM/0oTYaqV+FeW3l0ybhoQKHL1PcMrUbZAQ8RfbGWWgdgOJZkdo8b1EWdEC8XbIjQZO5xhiwsbADMxig7YBitxVr85uD+Y3/Vc4yYR18IpfJGFZFYxx7dpLY7uspoc6jJGHm3icAOBBix6kq28u4ZZJh9f1GtlmZhF/HOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482667; c=relaxed/simple;
	bh=sXz/WzDcNS541Fd94pgZWuDQ/YWU2XKOceibtP8FCK8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=V60Tdj7uRGB6NX6qsz+yxNgZ0aaWXy5ZerwCEX4sVf1vCQlLWEsuKGuYLJYKpF99mr/S/2ySy5K++nzBpqV00tphinRmrwFp/qjcGnc+rqAVNcwAd7iNucqiN0koaSUpfrUoiPxGgC8+W3Q1JqiTnp7Mp0wtH+9hWLMeyC+yLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4SovEbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4SovEbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2861F000FF;
	Thu,  8 Oct 2026 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791482664;
	bh=sXz/WzDcNS541Fd94pgZWuDQ/YWU2XKOceibtP8FCK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P4SovEbzX4DCjFvKz/pp2MZ7x4ihEvE7kGB7GWT8YI2CsATkq84ShGPzVf7d/FtJH
	 Q4VYhJneOvnLEOxhBGRteHb4ovlwfX5v4mZjBnyja2Iri8ws9ei90SnLKN38i6ILtC
	 fwxGWtxbS3JHaMViueiiAOSRjb0BIwZ38P1TFYluubes3aFcUnf4fbquWOkFTRmut7
	 0g9GjhUb26MX+2QDiACZJ+q7Wf+jX8R01IttdXSdte79VgGXc5u8HOXfz98pL9LrtN
	 7/4rLrtlQaYlC4J9Hvq9liraFE1bqVPRvBUH7RA41UZoN9bA9Pb9I+vLwORtwOlqI5
	 Zf7ErLZ+47bKw==
Date: Thu, 08 Oct 2026 08:04:23 -1000
Message-ID: <b064c79615e33deb06e9483e4ddf23c4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.4] sched_ext: Keep proxy donors with
 slice left on the local DSQ
In-Reply-To: <asXxp0WabkwdB5aw@gpd4>
References: <20261002221559.3090900-1-arighi@nvidia.com>
 <09a36d7e76652beedcfb891b587a9c82@kernel.org>
 <asXxp0WabkwdB5aw@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Wed, Oct 07, 2026 at 09:15:51AM +0200, Andrea Righi wrote:
...
> I think we can do this without modifying sched/core.c, sched_ext can set an
> SCX_RQ_PROXY_BLOCKING flag around its calls to sched_proxy_block_task(). When
> proxy_reset_donor() invokes put_prev_task_scx(), that flag tells sched_ext not
> to reenqueue the donor and block_task() will dequeue it immediately afterward.
> This should avoid the transient enqueue/dequeue pair and the false ENQ_LAST
> warning.
...
> So we need to add two rq flags in this way, SCX_RQ_PROXY_PICK_PENDING and
> SCX_RQ_PROXY_BLOCKING, but the whole logic stays in ext.c (with the flags
> dfinition in sched.h). Does this approach makes sense to you?

Yeah, that sounds good to me.

Thanks.

--
tejun
