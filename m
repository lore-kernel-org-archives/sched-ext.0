Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733F156C6A;
	Tue,  5 May 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994089; cv=none; b=OIa3DM9w6qN1oiiQtp8UCDbvxhpa7UZHvSCxfZwhaIhet654F1e8SQlqPfvZlyrgcsSEkCSuR8hsiCIlLAchzK0ZSlfOuglVZFZQFzWRDZPP8hHRApsQbr+2aFuhdtdA/SIKay/CickqNrMUb4jSdshrBwXRNeCVI/2AVSvZV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994089; c=relaxed/simple;
	bh=i00xHgf+4h5NX3idDFtY+fJLg5wnvyIanAPEl8yW9ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcEKv+MDtW9RvUbWkyjqQdtIvefIE3yPSyStqzeXgUfWio/KcLOo6KEBnAXNKIEWWC1o1DccySjnf9VuncodNwl3WVzTr5Y67B91emd9N2IJM1z5kGNhY/V3ohpfn0yt96lcMGGBDc6mF/1T2/A/hpa5JoD47IsLL8hxi04gnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAMaPAeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAMaPAeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B808AC2BCB4;
	Tue,  5 May 2026 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777994088;
	bh=i00xHgf+4h5NX3idDFtY+fJLg5wnvyIanAPEl8yW9ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAMaPAeTOqD4VRx9+6ssoChkjgWo7eij+YJ4+J2Bf3CPxZUitD/Okc36mRUWeXXZT
	 8BSd6hOM46pk2/+EanZ5MBsm/veRYZN2bJjqbYsL/K2cAVoh8ZewlHsxdirnvOq3yq
	 DL23snlWqJJTijzpHLDmrH39ZyMHoc8pL1sC3JSiplzjMtx26J5cddPsC4uvpZT8dO
	 I9OgBBo3VNLwkZzOEjoME4MRG5OiRPIu3UEk2cB1c8jDpw9F63fGXPgNcdgy0slZpy
	 q32f6dHsSPOwPq7/3m+D5/b/8DoJKqk/tm4EqkFqAxivyXcx8KzAPZ+cx26a8lT4tR
	 VtivpDBrF9Log==
Date: Tue, 5 May 2026 05:14:47 -1000
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
Message-ID: <afoJZz7SWmH8TlAF@slm.duckdns.org>
References: <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org>
 <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
 <afkOqQRB1YqSlL4x@slm.duckdns.org>
 <DIAL292DWST9.1UIAWWSHW1UMB@google.com>
 <afmq4DtGZcf4Zh5D@slm.duckdns.org>
 <DIAMMLYHMK8R.2B472NGCJEKP5@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIAMMLYHMK8R.2B472NGCJEKP5@google.com>

Hello,

On Tue, May 05, 2026 at 09:13:57AM +0000, Kuba Piecuch wrote:
> Ah, interesting, I didn't know there's a pure-BPF implementation of spinlocks!
> I haven't really had the chance to play around with arenas yet, looks like I'm
> missing out ;-)

Yeah, I'm pretty excited about it. If you have a moment, take a look at the
qmap code in the following RFC branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/tree/tools/sched_ext/scx_qmap.bpf.c?h=cid-arena-rfc

- Native FIFO data structure in arena. (SCX repo already has atq and other
  usages but this is a simplistic example)

- qmap_set_cmask() (the RFC part) shows kernel <-> BPF communication through
  arena memory where kernel directly writes to arena and pass the arena
  pointer to ops.set_cmask().

Thanks.

-- 
tejun
