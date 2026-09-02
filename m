Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3939CD11;
	Wed,  2 Sep 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332228; cv=none; b=SDSbr3l8Pb17ikUzfXdVdZVN18U1YzxW6VbhvmhYD+jcZT1PxHLQdn/FPw5+MoStgbsIOuebFS7ynSVnEZ0cND97x2OUNapcN5NYQcFbSySUzUoTNgVlXLRCfSMNif9GEzCB0AVU9GZVDjpObIV6DYqhnWrAhvgAxUukLdDRvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332228; c=relaxed/simple;
	bh=BeSt1yLLBygtJDuknwIfiypESPW1R02Br6MDmScUFvw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SAljEnCBtQO7FHyk5pL/kByGHV0Yo8TMhL4FXfynCK8U7Tw20p6zvbdCXNJng0PMTxiF4hFi1b6t69h2Bd6Ho3caj8qVryRtNH1YyzI5kBegRbDZEiPujVF1agGI9PHK0ZvHDVQjmaQ+BnGs+fePMTBAOP5cEl/POL0h1+2k0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFE/1VZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFE/1VZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155CD1F000E9;
	Wed,  2 Sep 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332225;
	bh=BeSt1yLLBygtJDuknwIfiypESPW1R02Br6MDmScUFvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JFE/1VZShS973TmqQMkWciGBNJCsf1VExYaQD7vZQ5+IN4HShuxW+nG27QQRfGFiU
	 vZMbyLEeQONhgDolZSyK9TkXwXDYZY8oZrU7HKc8LKgYe4P4GsGjWJc9P1FM2gebQk
	 EcV+DojYS5vyHZjt1sF2tE6K0v3Irt0bvZSb6HFCXwMZrUCj2EVs0Fne/XOHlk2ogm
	 oulzVdu3U2LHY75lRSnU0UtrjS0+pSfLg4anpf54JoO+VD1LSRQl/6NQEijSERnNy0
	 kR+YtfvTKahTXBso2wi1d5cS1j3ZhPNDnarl2M4JsgFyfSg/oyjTCSNzfTN+D8z9zf
	 +2Q7IHgq/a2zw==
Date: Tue, 01 Sep 2026 20:57:04 -1000
Message-ID: <bbc31cd1b97a4d0d169103b391a278cb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	zhanxusheng@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Skip per-CPU data allocation for built-in DSQs
In-Reply-To: <20260901013258.1822890-1-fangqiurong@kylinos.cn>
References: <20260827082329.3368255-1-fangqiurong@kylinos.cn>
	<20260901013258.1822890-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4 with Zhan's Reviewed-by added, the description
reworded to say the waste is quadratic in the CPU count, and the
scx_init_dsq() comment reworded as the local DSQ does track deferred reenqs,
just through sch->pcpu.

Thanks.

--
tejun
