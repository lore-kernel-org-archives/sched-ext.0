Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DA414F98;
	Sat,  9 Aug 2025 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754766081; cv=none; b=nJch+ivz44A/Tc3KZxmcLFxZcyXEfRLqzAKa0OVFOpHDIu0rvAn6l1gjyCqhgWbAfbxyDATbulk8X9Irdk2Matl5yKVRxocfSJfVwbF3u3/J1nxWv9Jom9+Q+f9q4RoFaMtKXkLKkIpA8OlILYMw7FfVQb8VsjguN2f3fe44+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754766081; c=relaxed/simple;
	bh=CUacxdmFvysi53hYsVEHf8INyYQy3mel9lhuLyxZtrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2pw1N2LP5QkjZGf2oRyfeBWmg7K4uzHDs7PuOz9NfUbNxvU0bouDebd7ktWCSrIRQodIIearTroY5d/3dje8CNTw5sFKw+jH2JGsDTJmYDHjTSG9axZiiMXBOKZre1m57UV9H6lTQBrJx7B/Yq1J6ykRBobgExBdslMVFwXJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlJFxtQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlJFxtQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2603BC4CEF4;
	Sat,  9 Aug 2025 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754766079;
	bh=CUacxdmFvysi53hYsVEHf8INyYQy3mel9lhuLyxZtrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlJFxtQHLYV8OuZAygiLGvX8agKpJslt6OpXeZBDW2ViA56TFhzeVBwT2q5L8Fq32
	 mg5hIIirVlQAlaNTwSGMRo35sIBo/r70MvflROlFakeBt8ytwxryAtVNNkCAfgo1ug
	 5+woUP8XMfSF+P8tvBb3Y1YFMdIjb1tm9Ob3X/PR9DlLPvcXduCVRt3LgPKi/2U5DX
	 BW6BZ38W3CF7zCKJ9zNDSdSF/d4mK5TnrRvI/7LfzGk2VrlXraith+Diuez/d5s655
	 nJ1hjk2yeJ24bnSjynONrCzFVyHIg6uAo5H42CpBZK2u5E1cvte+0oMDpnZDRX8puV
	 oT/D5mkqtimMw==
Date: Sat, 9 Aug 2025 09:01:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 2/3] sched_ext: Provide
 scx_bpf_task_acquire_remote_curr()
Message-ID: <aJea_sEq9pRWgShm@slm.duckdns.org>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805111036.130121-3-christian.loehle@arm.com>

On Tue, Aug 05, 2025 at 12:10:35PM +0100, Christian Loehle wrote:
> Provide scx_bpf_task_acquire_remote_curr() as a way for scx schedulers
> to check the curr task of a remote rq without assuming its lock is
> held.
> 
> Many scx schedulers make use of scx_bpf_cpu_rq() to check a remote curr
> (e.g. to see if it should be preempted). This is problematic because
> scx_bpf_cpu_rq() provides access to all fields of struct rq, most of
> which aren't safe to use without holding the associated rq lock.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Applied 1-2 to sched_ext/for-6.17-fixes.

Thanks.

-- 
tejun
