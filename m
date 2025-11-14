Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81F31A7F4;
	Fri, 14 Nov 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128369; cv=none; b=iBEDA4vfeiYwWr8nGeI+IXhbsLPEtXzQhN8KWRksBong3zM1ik+GGSAI34r5w1hZIt3Ab9PaatqeaDHDURTiEmlByCPAOLh2CbFwptfv8MuLet30FrnHJ6AOXVfT1IRoDXtPBDbsLAYTsP6huuHbkRtoi3FUN93eZ2wX1DsjnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128369; c=relaxed/simple;
	bh=ZDcIMy5sJDh7Zd9t/JkS0yqTI6oRcEcKGLARvB/NXfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuUBg8TzPzLmLpm7++k+W0JQvFvCY4RSM4hmHclwEWJqDU1mV9NkYXpOeZf6ajiHLj7Odd6vI43YfpSt2CKkOFf4XgUbbUUEtBZKMP2VGy8Zuy68OfU4FlcQU9auMYNMW0QWKSS8mFn4EH6z3dBN1RErApA8n0tCoHLg22q226Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZrF8arW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZrF8arW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A5C4CEF8;
	Fri, 14 Nov 2025 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763128369;
	bh=ZDcIMy5sJDh7Zd9t/JkS0yqTI6oRcEcKGLARvB/NXfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZrF8arWe/BMEjtjGk+U8nhkK7gio4wcNf9rzjGbwVayfz7yGBCjNY80Sl4w77fxm
	 5Fnb8jfVvC6XSlQ86UzQUjk8xuPmfmcgZAkVZsF56tZtJdtw8uzH+ve7uzGMm2w/14
	 s+mvIfI4/PdJ/MWGDOr8XdDp9Q9OrPNXzA/N5kHLrcR1+kf9KGXWYlzyUXDgRqYeb/
	 pPq3Bs7G8bgbCtK2sUzcf0QBLeyeIQWStcMar4ZIg24sR7Wk1Zp5legbLPd3yuUfGx
	 UNtYs+3feh85gzr1qGbYftUTXfSARKRDlctAbPw7F46UZEwHGx6raga3rSRYtxeIPw
	 0Y5oq4V4qYudQ==
Date: Fri, 14 Nov 2025 03:52:44 -1000
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [tj-sched-ext:for-next] [sched_ext]  7900aa699c:
 kernel-selftests-bpf.sched_ext.runner.init_enable_count_#.fail
Message-ID: <aRc0LFnfbtMe16vy@slm.duckdns.org>
References: <202511141028.39aed7d5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511141028.39aed7d5-lkp@intel.com>

Hello,

On Fri, Nov 14, 2025 at 10:21:12AM +0800, kernel test robot wrote:
> kernel test robot noticed "kernel-selftests-bpf.sched_ext.runner.init_enable_count_#.fail" on:
> 
> commit: 7900aa699c34401cf5d0c701d9ef72880ddc1a83 ("sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()")
> https://git.kernel.org/cgit/linux/kernel/git/tj/sched_ext.git for-next
> 
> [test failed on linux-next/master b179ce312bafcb8c68dc718e015aee79b7939ff0]

Unfortunately, I can't reproduce this failure.

> # ===== START =====
> # TEST: init_enable_count
> # DESCRIPTION: Verify we correctly count the occurrences of init, enable, etc callbacks.
> # OUTPUT:
> # ERR: init_enable_count.c:63
> # Expected skel->bss->init_task_cnt >= num_pre_forks (611 >= 1024)
> # not ok 9 init_enable_count # 
> # =====  END  =====

Looking at the code, I don't see how init_task_cnt can be lower than
num_pre_forks or how the referenced commit can change that (it only changes
the exit path).

Thanks.

-- 
tejun
