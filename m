Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794192;
	b=fWNByN8dKN3/f3T57BZPYv6S60Zx3THAkFGQmFmJY5iVmwbOzAk05AJ7eAjNsIZsfjuI
	 UfgQ3/iCQhfq+5vplv1toC/8O6+x4b0g+kuYRdgr3b6ZHxsZYzRqWuJxVSBINF/4kYsEg
	 2mxEBiyVaKqh0hxfIcKi51QnUeiJyyyvx+cGJPwoNRuX/B0bsWn+ikdyp4cB/QkEJQPLA
	 erGpTMwVHL1q+5mlC+0exdNhHW/HjRw08cSS/HDYYUdIx7XLeD1gHnzSVbk5dktkEXHE/
	 658ZXxEBvEm+bRSo+A42SHJzkObhZ6QUfw3B0ZrW/mS+8xknECLsKm7rLrDO7FNDIrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794192;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8tDnOWEOVrHVzVHH8lvLDE05wWsAuWmTyiKpsnBZc0s=;
	b=UItp2SSO9oZmObKysblJY2NoZFHvFURDDcBraRg9FRvJLtXyu9GNizoYbAbQTr8DbbJj
	 73Cg5FMt5cCdiYBp6PMaBSJiDek/7vnMQE7KTg8R6bzufsIfO2tL6USo5f96tOUO18lDM
	 ugdxirgYddyU3PU8mESV/wTl63yD5WEifnaT4ofExxsHVwqlegiUw3QN+4EVaPTsmZNUE
	 TrZBujRgubFkXFAwQ7Ez+H2+4bcBTsYSeVwXUGfj2fFCH3cOxC58Xw4F7aHTR1ygd/AGC
	 B+C7haOx4pWj/TBOisM/lUAWl5om8TqvXBjpgn+yqczWJ1pJgEJmTAjD9/qVXJiHn+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7wx0EzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA9606A31C;
	Fri, 27 Nov 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7wx0EzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D221B1F00893;
	Fri, 27 Nov 2026 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795794192;
	bh=8tDnOWEOVrHVzVHH8lvLDE05wWsAuWmTyiKpsnBZc0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X7wx0EzJ3F0XXLYSfWLqEw1PrP545+yY8NsoOSq+gRJLhw5mNDSp81z0JrsnLzs2B
	 8Ob4SIlR8z0SMH87DjJXLvAvnI+OOXyV6tO2OlSYVviWUYAd1+pCJgGFEVrytPoK4C
	 9spjwNk7uSstz/IdhED9PAxPG4qo7QJKukRjxjtRcLyeMTaheZE8xRMu4z4KDLxm8T
	 UkG6Mw4krwgLMVGzVoImKEt5pYhoxSypbB8UpGzXh/hBpCIH5Z3Bfe+UU6w35trabV
	 sH3ve3DhvY7CG/DjzURj9vyZDDYvQ/iKibt8dBxAVLfQAXOMY/9EjEhWSm8CyPTwgr
	 CvCTcixJtJ4Pw==
Date: Fri, 27 Nov 2026 05:43:11 -1000
Message-ID: <8e4043f995e96c0d4642287bc5009000@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHSET sched_ext/for-7.4-fixes] sched_ext: sub: Don't run ops.sub_caps_updated() in an SCX op context
In-Reply-To: <20261125153353.1364467-1-jpiecuch@google.com>
References: <20261125153353.1364467-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Kuba.

On Wed, Nov 25, 2026 at 03:34:19PM +0000, Kuba Piecuch wrote:
> scx_bpf_sub_grant() and scx_bpf_sub_revoke() are in scx_kfunc_ids_any, so
> a parent scheduler can call them from any op. Before returning, they
> deliver ops.sub_caps_updated() to the affected children synchronously:

The synchronous delivery is intentional. Once it's deferred, it becomes
unclear what happens when there are competing updates.

ops.sub_caps_updated() is there only so that a sub-sched can propagate
grants and revokes to its own children. It isn't the place for any other
operation. ops.sub_ecaps_updated() is the one that reports a change once
it's in effect on the cpu and it runs with the rq locked, so anything
that acts on the caps, e.g. setting cpuperf, belongs there.

All the listed failure modes are self-inflicted, e.g. a sub-sched calling
scx_bpf_cidperf_set() from ops.sub_caps_updated() or a parent granting
from ops.dump*(), and none of them is critical. Isn't this more of a
documentation problem than anything else?

Thanks.

--
tejun
