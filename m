Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ADF78F26
	for <sched-ext@lists.linux.dev>; Sun, 28 Dec 2025 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766938961; cv=none; b=g9JgC1RE0xwQ08qUXtwE3N2edMV9yl/q7zWStie9t57Lj5nXnZvz2EqxEefjolja3DyUhz9/SgvhFSzBnVzpHXOPtiENiNS3Bz/D5F4OnXwWKDmb406cCgrJITMa0MDnLLBbrJ8PfbI+mXGH8z08v/7DIbBzId5gbjVDXCXuMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766938961; c=relaxed/simple;
	bh=lKFmykX3QXzszx7AvKPVqAXAFW7R98l/VJ+k0Ym4xFA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hDWIGE2oolxcrf4PjItf4jbtNzlYV0SQtlyC71n3H6hKN1gVvHxq9jTFFnkGt4f5rWG2dCUKgxTYhXZrFF88MLjkR4F1a8EPwgCEzEyoyxNauj00HENzJ0i8Fqrr8eSz/adIXVXmrOIRXg/F+EJFvd9169dT7/CcIF1hzjTwqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmj+MDzv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmj+MDzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D0DC4CEFB;
	Sun, 28 Dec 2025 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766938960;
	bh=lKFmykX3QXzszx7AvKPVqAXAFW7R98l/VJ+k0Ym4xFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jmj+MDzvmQNigQnfmLleOR2koYtrpKs06LVSVvhOCm+4FR/6OIJUpo1FnA1y1281W
	 DFK8WpVzyT9T4+WkcAvKy5ITc/92DTDE5gK8FnUilN8DagZKEvt7A0+NfLO7R7yasl
	 dOcHnSLQ/I8hxbcFmGrspV8PMSUh++ND5SoQVlPC8j/sPu7YHDFkQfanvYYykClrCK
	 vRx37mWEkATZbpnSOZJTCStjesj4WAF7EgUI9ehc1a1fWCK3Q4ux+IXlwwDtCXtmCk
	 07gIO8ECTd0idfImNlnsGvkHvMULTqV9DI9MHBVJ1xP9F1Ilckc0vnMj99VaVT1nFs
	 VVt+VcI63sslQ==
Date: Sun, 28 Dec 2025 06:22:39 -1000
Message-ID: <b23313de3273d4c87a1c315a1cd49136@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Dan Schatzberg <schatzberg.dan@gmail.com>, kohei@enjuk.jp
Subject: Re: [PATCH v1 0/2] tools/sched_ext: fix issues in scx_show_state.py
In-Reply-To: <20251226084657.75567-1-enjuk@amazon.com>
References: <20251226084657.75567-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> Kohei Enju (2):
>   tools/sched_ext: fix scx_show_state.py for scx_root change
>   tools/sched_ext: update scx_show_state.py for scx_aborting change

Applied 1-2 to sched_ext/for-6.19-fixes.

Thanks.
--
tejun
