Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1C347BAF;
	Mon,  4 May 2026 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929899; cv=none; b=Z7PN9wPzK2x2k6mbPXxDau0DxV9qT9XTcuoY0a2UvbfdC/kRGt3DMiMFCTmCvLHw8aBtA9YocICWUINfAd2JvWDEz+fYZApSsdMfjyGkZjHF4OdEzHZHkXmsC97hX5eJGK2k3+iMGkyg2Waw3DMfA57vhM9RRjdziqa+YAe4XlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929899; c=relaxed/simple;
	bh=0/HIrDb0QvlX7E2J7c5JMdLMHxZuXmV+lQjeyNW41Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKsVNJHuMPubkXvFGEkbiuux6jnVKzDhxwWcWnmbk+LlpsElTWsc2bUAbaYQU/4OtIF+eS4T1BTEPm2blzxLkU16Z9pjPeGEas7V69OsywSNF1OXZoFuSGdkPeVFqVyuXtMhM46CYKkWRhQu0FHZAnqmTRBBENvGuyrMf+27fjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJQWpnqZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJQWpnqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E72C2BCB8;
	Mon,  4 May 2026 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777929898;
	bh=0/HIrDb0QvlX7E2J7c5JMdLMHxZuXmV+lQjeyNW41Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJQWpnqZIJ8Miix/SaQQit0nW6kiyy3d2prc7PkfQQm/+EmtYGgD8x8GGfZAonq1q
	 2nXWSMccNSYWM+wYbcA6gKl9bAoPdjpQEGGisUsf3V8R6ny2f1jl+8GOInkqX/26xp
	 Q4oMKLnpfF70esJLfoU+UojvLkQZfyT9umdiHo5evhMvTVllzJB3UE4N965ET8KmxH
	 E/ZFedVCUkfxJOEkN2XcqIbE+z1/uGChm8y/0OWlwK7JSFhan/rvZUiAkFDsmHWakW
	 3+9ezBt8fuBlyu19LPjho6NCkifDpVPGWdbfYEE+SrFACHGTk8UzI5jCvwrbDjUSKs
	 6m8ENmFogVTZg==
Date: Mon, 4 May 2026 11:24:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <afkOqQRB1YqSlL4x@slm.duckdns.org>
References: <DH6OUDJUQNA3.6L4YXJMME4KI@google.com>
 <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com>
 <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org>
 <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>

On Mon, May 04, 2026 at 08:00:50AM +0000, Kuba Piecuch wrote:
> Random thought: If exposing qseq values to BPF directly is undesirable, then
> perhaps a less objectionable approach would be to expose them as opaque
> cookie/token values? Same semantics, but fewer SCX internals leaking to BPF.

Yeah, cookie sounds fine to me and let's clearly note that this is for
schedulers that don't implement properly synchronized dequeue.

Thanks.

-- 
tejun
