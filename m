Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8533FB060;
	Thu, 28 May 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983589; cv=none; b=iRPseT5BRnnmt9meUrRHk8Qk5JJj63bOHzLviZWwY05Klf7MldAOZbgd+E/PExLxK0k/Q9CZ6KdQk7VQOSZB5Iu+8vAtBdw9owhlII6Pb2JgTvaEfgWKpHvaleGPBcBj4LkbfDMGL0mOOHTzqC96MIB/lFfYtL3OLpelkAfvEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983589; c=relaxed/simple;
	bh=83M5PDmPGrvmoNJqLdwU8+Dt37hDtgzFauJxsZwTSQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVyKu4ZWmYN+LJhnMYK33ziQQIMxbEWTOjzOYE3oVqdAqd3/5RHtEc8Ar3u1MLSMsiCXxJeazIMqDYGOmC2IWUHn0zVfCmlXZemoHQ0BhFcrDce6U4jdgVr9KU7dAlixPuq5HwlmBAgfTlDPYr2c4QQuOi7PA8G4/WaOWAKw9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8vZXfVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8vZXfVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE51F000E9;
	Thu, 28 May 2026 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779983586;
	bh=FovXavx2IpK1gXJlS2axJn54xpz3lUMMpBudCwNFYms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y8vZXfVv+Kbm9UilMNavkug89sOCddqbbRqEdLaYPVBtQotDuDUoit8DWoRQjjEbj
	 3o3wdCxD97rPeN0Kh0tHn8VTBeuieHeT35vAc+yJr5bKZ+H8uluvfjXLoaF9hb9jhc
	 DyNgLGFx/OoAnDKLZftcZgJCXFGdKyGB7EXb/2wqUqCBxhD9lGVxcFTXkpDkDFjmzQ
	 L3QuaS0HbMt4uFZ+mtlcR9+TZDz3/ggq/0/x/kKFR+rcWvPy8q7jsnqBsrMFAqSDH3
	 CRJLRjDjCr6WS1qy9NVT5ISJLPdKem7WnrmgKy7thDFIH+s8cO46FCOjP8RhbBMaRV
	 Z+Uk3tIbkDFjg==
Date: Thu, 28 May 2026 05:53:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>, Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.2] sched_ext: Auto-manage ext/fair
 dl_server bandwidth
Message-ID: <ahhk4LJwmJCNLQp0@slm.duckdns.org>
References: <20260526164420.638711-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526164420.638711-1-arighi@nvidia.com>

Hello,

Peter, how do you want to route the patches? I'd be happy to take them
through sched_ext/for-7.2.

Thanks.

-- 
tejun
