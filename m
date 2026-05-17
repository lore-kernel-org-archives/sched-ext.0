Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443D3C3BF3
	for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042012; cv=none; b=WMCuFqGY8fWdvzxoJixwnlD0VI+jPwWg7JXZJLkk4itTT58M1R8jpByig9IYQnHLWQXzlKbc1pKHfIH7RcrEytZXC5WKAFeQ1d/2k8LofXuHBSDy6AESjaVw1gUJjRoAACEO1qT/CH1v2px96IMy4GlQrvMPfT6scbopbMl+kFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042012; c=relaxed/simple;
	bh=9JLQmfZ1o1V7KlsMNdCc3eHYgQ3/3UiTmvm0nnRPG1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oru34JvWDzWz8TXNt6Zt26HsI/f4tY/8D+hQ2MfH9YTWPKU2QeS6RoZDih4CEMPvabTa/Whiupo++f9fcNebDGllh7p1WA0y4y6FcJ0PwyiyZSLKzWYTr+UE4Wlt3ugWzdR/MjiiAjF4SGVsBlANvCxto10PK0bs8LLSxPs88+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al/UYULY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al/UYULY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676B7C2BCB0;
	Sun, 17 May 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042011;
	bh=9JLQmfZ1o1V7KlsMNdCc3eHYgQ3/3UiTmvm0nnRPG1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=al/UYULYW0lOaGKHNxE2Q8EzM+1K3z97SgvyOIzHfvutH1kLluEGRb4kmENlq59jt
	 mBYD0V6P7wLiRVP66dr3t3ApPzO/7P3KVzOWpZBcu5XMDYcnbvM23F809dvoyviYfd
	 cxq1z5W/zC7HWS1uo9ILyvFndHS3S9mDPa3Qb5T14BHpCB+bGctLieZ7XX4kYRnd1X
	 uKEnU0+5EaPJg3msCZW7AorXVMXQiyuPhJm6UhYr8lVncLS4z4QR0FKz3+y7Hp3nb6
	 s9GZV0Ti9Z/qB4QKJdzaTvuIaAwqWYgU/CIsu1ZOq9rLqB4h6SXYJSZrdL3G7H6Y+5
	 hAVUqw9iYJlQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] sched_ext: Rename scx_cmask.nr_bits to nr_cids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260517181022.1184056-2-tj@kernel.org>
References: <20260517181022.1184056-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 18:20:10 +0000
Message-Id: <20260517182011.676B7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete refactoring of `nr_bits` to `nr_cids` causes a compilati=
on error in `cmask_copy_from_kernel()`.
--

commit 7049bf95e9f693c1107678499b063bd2c1a25e08
Author: Tejun Heo <tj@kernel.org>

sched_ext: Rename scx_cmask.nr_bits to nr_cids
   =20
struct scx_cmask is a base-windowed bitmap over cid space. Each bit
represents one cid, so the count of active bits is the count of cids. The
sibling struct scx_cid_shard already uses nr_cids. Rename as a prep so the
following patches that grow the cmask API can use the consistent name.

> diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
> index ebb8cdf906123..c6c4e3db73111 100644
> --- a/kernel/sched/ext_types.h
> +++ b/kernel/sched/ext_types.h
[ ... ]
> @@ -82,21 +82,21 @@ struct scx_cid_topo {
>   */
>  struct scx_cmask {
>  	u32 base;
> -	u32 nr_bits;
> +	u32 nr_cids;
>  	DECLARE_FLEX_ARRAY(u64, bits);
>  };

Will this rename cause a build failure for BPF programs using
cmask_copy_from_kernel() from tools/sched_ext/include/scx/cid.bpf.h?

It appears cmask_copy_from_kernel() still references the old nr_bits
member:

static __always_inline void cmask_copy_from_kernel(struct scx_cmask __arena=
 *dst,
						   const struct scx_cmask *src)
{
	u32 base =3D 0, nr_bits =3D 0, nr_words, wi;
...
	if (bpf_probe_read_kernel(&nr_bits, sizeof(nr_bits), &src->nr_bits)) {
		scx_bpf_error("probe-read cmask->nr_bits failed");
		return;
	}

	if (nr_bits > dst->nr_bits) {
		scx_bpf_error("src cmask nr_bits=3D%u exceeds dst nr_bits=3D%u",
			      nr_bits, dst->nr_bits);
		return;
	}
...

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517181022.1184=
056-1-tj@kernel.org?part=3D1
