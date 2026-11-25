Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625776;
	b=AZ4oWdBVP5bFDv31JSTP/T5pg4LkzaNQN1PAw3191EerAmIZtnSztVYPaH+Lya+bjFWd
	 pZpeFdIeo6Q9I/lbRvqBB/wH3lIKfegP2CgMrq93ZjinM6jlOYRQ79tpqKAAtZQeagz42
	 KxXYKK7ZC3TxSlKiWzx/xxcOkGerC4y74Z6Fuh5xf+AcRkE6GNg0RNPRwS+O5TZl9d5Rv
	 Unw8vEDGszpd3TvE2cKHNIQFpMi7HjLTJgElo4Lap1LQBwpJ4agS3jLo1EMKkwFcL9rKx
	 D7y+SIUujdlyKNO6UAzC/8oaw2doqOC0aluo0YuhRd9I0tyFw+eZjn1Y5McX7noYzxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625776;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=j8Lz8QWd9bTg7CXsCiDh67LKWlSU1PU2SB1obVN10YA=;
	b=mnGAruu36zlsvJX0n94yExPCleu8pMo3AslhzajOk0vjmX/po1L6iT7579Yxs5Bh6Vda
	 jljr30UE4ArR4eAWi2YwEwrx/XvzxOJ5yXFZs+rSu351ll/hoif9XDPSo2uojANGVmqCZ
	 OPFnH6dwPKGYFZaV51mUeWrbf0Yq2ucbRwCKXFaglps5mSuvy2AobKwC5tPS5Y7mbUnPf
	 XVvG4SUelqDYMWK0dCEjZIT6xXcpHyDYO4KEkAFrJ+0vpN1zJwncsScinStXYiRWESJTG
	 vbe+LaJujW3UCEmoe3bsZq7IUhn+yBVwsimZ3PEQuyDj35wxzcP59ljIbvGrjGwhkBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSiShgvt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FEA606A329;
	Wed, 25 Nov 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSiShgvt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F7E1F000ED;
	Wed, 25 Nov 2026 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625775;
	bh=j8Lz8QWd9bTg7CXsCiDh67LKWlSU1PU2SB1obVN10YA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bSiShgvtcsw1PvOc2PO90bBZY3PJ+gLK6pilwDhLJAkqf9Ra9JllqG/myYVrt4zeu
	 aOjzktjBIJYMXfAVch3bgB9fNcteLFcfRr3ZVcWI+M1grPM+h3mcaW/VXZbpzvjuLF
	 smNvQwwN4CL0HZ2FTgdZ7ssfo89fFe2QyETS1JAnRxExZ5UMzleC0Wkt1hBm+qr/LJ
	 vuPWeF9vynC2Y1yNhQmgI/6pUHuJxRVQF0bKCUtRN83xe2zWMNYnqmdRi1qIako/hO
	 6jhMOeW9538EbFbXUr8BkPJfhIbrvJCmn4G6oqPrNd7IVdWx33VJGfbKYxegVUX5+J
	 2SMIAaIkFDvuA==
Date: Wed, 25 Nov 2026 06:56:14 -1000
Message-ID: <c3516afe34fa11bb42976188b7546233@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>, Hang Zhengyang <hang.zhengyang1010@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: Start ext_server from the tick
In-Reply-To: <20261125135723.GD2668804@noisy.programming.kicks-ass.net>
References: <20261125103420.2785659-1-tj@kernel.org> <20261125135723.GD2668804@noisy.programming.kicks-ass.net>
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

Hello, Peter.

On Wed, Nov 25, 2026 at 02:57:23PM +0100, Peter Zijlstra wrote:
> Could you perhaps punt the responsibility to the DSQ? Each DSQ has both:
>
>  - a count of how many tasks it has
>  - a sense of what CPUs it targets
>
> Right? So can it make sure nr_tasks CPUs of its destination are running
> ext_server?

The problem is that runnable tasks may not be on any DSQ. The BPF scheduler
can hold tasks in its own data structures between ops.enqueue() and
ops.dispatch(), and the newer schedulers do. Also, only local DSQs have
target CPUs. Any CPU's ops.dispatch() can consume from a user DSQ. So, all
the kernel can tell is that something is runnable, and only ops.dispatch()
knows which CPU it is for.

Thanks.

--
tejun
