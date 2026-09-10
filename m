Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B943C8737;
	Thu, 10 Sep 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035153; cv=none; b=D3YiaEbuW1GhZda+vsX06+NNlLVzGdL/6WbN2ey3sKan+m3qaIS434mwnyTNKaGWm5rP0fkHMKZ8FOQiYW04HMTkrfjePzCAITzpYduq1MNfyYCDcPPVzxxgODD6TxTtNqfpt6yIs4wj7U4LVEldJI/0SEFHy+h17pe2V3BFkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035153; c=relaxed/simple;
	bh=l2RHetgpE6CCStrryuJ7l/Z2ivQzhHgb6HI5gwkbE2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLOIOceAvnY2Oon+jLER0jIS/jsSg/tLs+97LrEjeUUz9vN0UwpNdpl3eDzSiAn8No76s+UqETp3MVp3rBcZXPwakp+k50+QlcThMoFu7cpZhnnrixyQXJicrubBoAKVmv7rjnTyoKuAxFO+S/PjClzMZHmgC8TF3ASMXuG113A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z2eayi4g; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2eayi4g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l2RHetgpE6CCStrryuJ7l/Z2ivQzhHgb6HI5gwkbE2I=; b=Z2eayi4g8jSnKkjMhZcNI6wiQS
	Y8S6PUMLx5SIS077nSXzLW5KGPxAAKpiyt7X1wOZZ4zvZ6B/5LkF4ZsYX16MKBqiZky4kdqdWTFwe
	DXfU7vpD18Fn4+IT7MkeIEJVOKFjUOGpdAhq+u/h/MF4jm2x4LWod7reKQ82fL94DXACG3cW08BR6
	Im6jr8XJEbG1/bZjjILDfLeIpZNTgPCbl2honfln/paHvN+nbYvD8n0RPyZSc3AMD/W3ppLt0JgON
	jp94NIoUYJWJ6TjRX44HBywnx6eJ3JUHBusEvu+LIS3/6rQPYuKHLPTNRraYP/6pz9bqCNOerEJAD
	VbahsHBg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4blX-00000002JP4-3qLQ;
	Thu, 10 Sep 2026 10:12:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6EC930056B; Thu, 10 Sep 2026 12:12:22 +0200 (CEST)
Date: Thu, 10 Sep 2026 12:12:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Emil Tsalapatis <etsal@meta.com>,
	Lee Trager <ltrager@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] sched: Pass next class to sched_change_begin()
Message-ID: <20260910101222.GG4120091@noisy.programming.kicks-ass.net>
References: <20260831134338.1531664-1-arighi@nvidia.com>
 <20260831134338.1531664-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134338.1531664-6-arighi@nvidia.com>

On Mon, Aug 31, 2026 at 03:42:15PM +0200, Andrea Righi wrote:
> sched_change_begin() currently only receives the task whose scheduling
> state is being changed. It cannot distinguish a class transition from a
> same-class update before recording the task queueing state.

Uh, yes it can. That's what {EN,DE}QUEUE_CLASS are for, no?
