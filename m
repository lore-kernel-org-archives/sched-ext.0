Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82137283FFB;
	Tue, 11 Nov 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886355; cv=none; b=hQPJhnWIABd8zpkg5nJMXuhzbmjremLMCBivRh3jDvfXvxm74MSC4EKECxDkx3zuEUTaGDMT6lHPGY0emzPSPLX5sso1nBdlU4gKPQ54mvrWEtbvY0tY5cUHqACNB9UAuTHPRBuDZYV8HXvou6PnFAcBWrO+YF1+PH546UJJLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886355; c=relaxed/simple;
	bh=EmvvZ9rJPj3B+nCv/zAC+fpF/u+fTuG6nH5rmGZc40Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4dQek6lvaOiy64/baOeD3b55/jhv5+IWgRXuf/LEUdDxNZF6i0rEOpXrFneGU0L5DsHjfn/qoHr1r5Y8pwZynyMUCAOKV6iYM4JKPXmSYxUSKgI15ZhCQ1GbMOXoH1BA7X2nJDRqDvNr6nZTvzh4IbSsJ/GPWROEiQUUIMFoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqaAopvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqaAopvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C80C4CEFB;
	Tue, 11 Nov 2025 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886354;
	bh=EmvvZ9rJPj3B+nCv/zAC+fpF/u+fTuG6nH5rmGZc40Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqaAopvwZPbiVUJ3BC5iEwLY4bVcn+Fi8A4g96ou2e+s4rnZy8DEt81yuoTBxFjep
	 GqNtZYf1Qd63kuGw8243z/L8dlFUw2pnntXbYSXb5gHxRhj2C7NORg8lauJ1F9W/YO
	 9PpSOcrQ1bSIUZkspj4C1vWtT8L90LRtFRcgYa/tqwSIMZ1lXVSWpLrvERp3R2e66n
	 jatHsZDeYFMtIXvIfOk0Qr1owswZJf7Kz97n7LPM0vphS/RQTYWbA5GOHA1tACtiKF
	 APlEQ6AasmNvCfTGVz3XwRkqnWlvpwTZJoXFJB6jEFY6/QUbWmJlwhp+Ez5+Kikb73
	 f+FEdAiX1dbQw==
Date: Tue, 11 Nov 2025 08:39:13 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Righi <arighi@nvidia.com>
Subject: Re: [PATCH UPDATED 10/14] sched_ext: Hook up hardlockup detector
Message-ID: <aROC0U_aCX9zdwU0@slm.duckdns.org>
References: <20251110205636.405592-1-tj@kernel.org>
 <20251110205636.405592-11-tj@kernel.org>
 <aROBfmtos9_3RX9a@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aROBfmtos9_3RX9a@slm.duckdns.org>

On Tue, Nov 11, 2025 at 08:33:34AM -1000, Tejun Heo wrote:
> @@ -230,6 +231,7 @@ bool scx_rcu_cpu_stall(void);
>  static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
> +static inline bool scx_hardlockup(void) {}

Ooh, missed return false. Will post v3 patchset soon.

Thanks.

-- 
tejun
