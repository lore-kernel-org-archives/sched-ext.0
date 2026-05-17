Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B93C3BF3
	for <sched-ext@lists.linux.dev>; Sun, 17 May 2026 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043438; cv=none; b=ZtcteKXyfT78kLQsjxOsOUpT2IywJKgoUg/9+nu8fg1IRTNMrr9zvsW62td/MWmV2TqA5+jYJ+JWlf71IcK3DOzO+z/JqApUwSh4UWJIx6O9aPqJH6IKJh4jLiVQ8SmTPj6uBhTw4kUnUmyaIKxd/MY9qdPToM6HaKEW8gkSThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043438; c=relaxed/simple;
	bh=uQM1zraTdqBSzK+v27EqUs2AFpWIBVNEzYoFbHZI1W0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ICaaipElvXVjX1YUvuGT/dvQqmKq2uQNrhXCr9R8QnkxdOM3h1hVEPQTa/3fLqrOCFBHqcYin8nWXbZsFDNF24VpgbeVcmH2oFuSkSYoggqo+YZb3WyEQaxNX5okDBpmNbWCgk//XcEZHvHGrHGsKsXdwbDDuv1ibfVr8yBZvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKRh871D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKRh871D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBB8C2BCB0;
	Sun, 17 May 2026 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043437;
	bh=uQM1zraTdqBSzK+v27EqUs2AFpWIBVNEzYoFbHZI1W0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CKRh871Dkq7Au1ueM9OJLWH6w2qd2COqqInVcnh09wm5bJ21LamEqFRqfFlrddE9C
	 fMJSBUmrGSj19pHZ7GlOVi6tlDIW1m6SaJlmNpv96RjoWeCGxAsRaMEdExWp4OlbwR
	 6v3hpKtKsVA2ximVSdOtbuAOaGtUXnp2Usdfn+QwSkxC4r8GzZ7da50wm0DOrnYRhG
	 kuxRDV933SmYvXtGW0j8WQFEunLQM+0zlbWFD8UHvKH3jz8F46hqsnobbeDk54eXcM
	 IFBBogL69m2gjZ7+EVVMIgkoR/9DeHtvEycqrBz9FzcfsS6go9tCj1KvmCGBpZxo50
	 sEkGD4Gl1Cs3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] sched_ext: Rename scx_cmask.nr_bits to nr_cids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260517183614.1191534-2-tj@kernel.org>
References: <20260517183614.1191534-2-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 18:43:57 +0000
Message-Id: <20260517184357.ADBB8C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The struct field 'nr_bits' in 'struct scx_cmask' was renamed to 'nr=
_cids', but the function 'cmask_copy_from_kernel()' in 'tools/sched_ext/inc=
lude/scx/cid.bpf.h' still references 'src->nr_bits' and 'dst->nr_bits'. Thi=
s will cause a compilation error for BPF programs including this header.
--

commit 10e6d97c74e4139adeb947156f1940e0b2848eb4
Author: Tejun Heo <tj@kernel.org>

sched_ext: Rename scx_cmask.nr_bits to nr_cids

This commit renames the nr_bits field in struct scx_cmask to nr_cids.
This aligns the naming with the sibling struct scx_cid_shard to provide
a consistent API for future cmask patches.

> diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
> index ebb8cdf906123..c6c4e3db73111 100644
> --- a/kernel/sched/ext_types.h
> +++ b/kernel/sched/ext_types.h
> @@ -82,21 +82,21 @@ struct scx_cid_topo {
>   */
>  struct scx_cmask {
>  	u32 base;
> -	u32 nr_bits;
> +	u32 nr_cids;
>  	DECLARE_FLEX_ARRAY(u64, bits);
>  };

Since the field is renamed to nr_cids here, does cmask_copy_from_kernel() in
tools/sched_ext/include/scx/cid.bpf.h also need to be updated?

It appears to still reference the old nr_bits field:

tools/sched_ext/include/scx/cid.bpf.h:cmask_copy_from_kernel() {
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
}

Will this cause a compilation error for BPF programs including this header?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517183614.1191=
534-1-tj@kernel.org?part=3D1
