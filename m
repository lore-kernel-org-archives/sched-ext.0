Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235973793DA;
	Mon,  2 Feb 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045593; cv=none; b=bs6K17+jK+TilYb5bjRMCzEQl0xVmRtb1KJOPQY9DpEYeWAUpJDDQOU9x/vbxQUSxZ3sRIhlJklmfWiysvcfqo+7LNWX4637b2TnUn37eAPKecTMZqlIV75VGql2EaZMSpzVSvC9ODIFSJfrG9MZDmdkVybj7WYjrs0jGT3nCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045593; c=relaxed/simple;
	bh=9aQ2GH1V6XU5sxZdQMJmz4EsN5xNxnEmFH3N07kGufU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2qM93rwsS7CeFcoXq7x1uU33vTsfyxImYXndtbJEPYkplhi8ea/6bs+plWXyR96hsw1vEpC+efhBLmDQaLm+J7BrNzMUohYOJjXsIWvNEP0aYVcW6QJvgRcjnQlIXO16wdcSopcwX+EmzUWf9TREdrYViNsMwCK9glWTCe9/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGcNx6k0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGcNx6k0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9C4C116C6;
	Mon,  2 Feb 2026 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770045592;
	bh=9aQ2GH1V6XU5sxZdQMJmz4EsN5xNxnEmFH3N07kGufU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGcNx6k0INlmHgbLXupjcz8hD1ShV0UDaBkRxH35fWCBhzpVcIUfBa91VhB76gEFw
	 29s2nx/V3X44h7xLBm20s8Tf3SO5O3WLjiHdlKyvkA1Z4s6ILfaCiQ4PXv4M2lt6QO
	 NJwVX97BCU3nH2Z0iwCVltzbK0u5ur3T7ueKqq56YFXQ/EUSECXBkm7BjE5jADmdBa
	 j3N7tyW40mPRfwFUwrirs3ALK92PsjRGtU3XOavRwqdQ7hng8a6Xn4NKUuOsUZkXHA
	 lixiHejuX53NB5pPlYKg0LhXXCDMoLnJ27E0NqV174qDFtr+weCHhwtfmcNOnZ2jbd
	 FWL7yRtSBrsGw==
Date: Mon, 2 Feb 2026 05:19:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYDAl7Q40rbbakrq@slm.duckdns.org>
References: <20260126084258.3798129-1-arighi@nvidia.com>
 <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org>
 <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
 <aX3FG00RNMv8VnQQ@gpd4>
 <DG2YT5LJFC9T.AXB2OHJBQG4U@google.com>
 <aX5lkCVr9uU78DxL@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX5lkCVr9uU78DxL@gpd4>

Hello,

On Sat, Jan 31, 2026 at 09:26:56PM +0100, Andrea Righi wrote:
> I agree that SCX_DSQ_GLOBAL behaves differently from user-created DSQs at
> the implementation level, but I think that difference shouldn't leak into
> the logical model.
> 
> From a semantic point of view, dispatching a task to SCX_DSQ_GLOBAL does
> not mean that the task leaves the "enqueued by BPF" state. The task is
> still under the BPF scheduler's custody, not directly dispatched to a
> specific CPU, and remains sched_ext-managed. The scheduler has queued the
> task and it hasn't relinquished control over it.
> 
> That said, I don't have a strong opinion here. If we prefer to treat
> SCX_DSQ_GLOBAL as a "direct dispatch" DSQ for the purposes of ops.dequeue()
> semantics, then I'm fine with adjusting the logic accordingly (with proper
> documentation).
> 
> Tejun, thoughts?

I think putting a task into GLOBAL means that the BPF scheduler is done with
it. Another data point in this direction is that when insertion into a local
DSQ can't be done, the task falls back to the global DSQ although all the
current ones also trigger error.

Thanks.

-- 
tejun
