Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394241DE08
	for <sched-ext@lists.linux.dev>; Sat,  3 Oct 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791027533; cv=none; b=H/5yXkcbFvwtxKrht5a4AYVnKEaiszSfpCN0fJ41ip3v9JroNpkeXELFH90bQlpeOYCyRUPzhnmZfn809zjcNtfhEIssrdQReuHgXreaeX/VfJOAnsF+QQ17lXXXJm2pofNeY+adqN+sOwEtyqSUS1cii7VaTPMWQbALRoxuUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791027533; c=relaxed/simple;
	bh=wFuneSHZBn6In4dqUVxijnRdt9U4NP0mkaXqbu76nwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r5GgC5G1AQCURf4fAezwv9KTKcq+Y217mbOZOdJaN3ZlSZ4kMyAnt/niAfJBopGQZUjkvrrBbpQB5Tj2vMEr/z8QvDQFxdi+xDu2pvIwkiZLTg4XYUlppVglg3J7VBDlbsKeh3GRWA80JVUu8x8+Coth9S9oGfWBWHm6d6LJL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9SKWfmB; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9SKWfmB"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af4a0bd0fso177329f8f.2
        for <sched-ext@lists.linux.dev>; Sat, 03 Oct 2026 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791027530; x=1791632330; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9l7ARbE8UXnS/98aYzt9PQ09qeddpRzbILa5zCOGi5g=;
        b=P9SKWfmBh2vC+5wlUvWN4BVsU6Wo6QNbLf1Jm2wKh7/LDorSlgIlYtW5qgQ20Om6kd
         gB7iurN3XjH/g6FKm3DXyGNMxEBxxNdgWstCqgbV/SzCx0KsAel1nuwn23p3uKZJwBgc
         /NkuTvBbkfK7PDx/QRexgWGmFxKuTMwc2GUWZNnL/SqaFFYrwlYmperG76pc/verMMEB
         lLj9tAidCQ2yJy+aH0KHiLYfPbEoA5UXRiFFbBAD4jJXw+baMLagqrHSeINUNWGpKgsr
         ztdGQtzTxGDlyrqGd+ffOkhU/cY5ZgeBi2NoE9hsKKM9MMJLlyTKs4cs4XFz1YGQCBWr
         L1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791027530; x=1791632330;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9l7ARbE8UXnS/98aYzt9PQ09qeddpRzbILa5zCOGi5g=;
        b=jAmoENm32Q7LbMz0o+9nigZfpVd9Sk5XLvgnWhyCzw5MYM7cZAgz2Eomfkh7PBPAJh
         g+UL2fITC9Mmv9PnS73c5yWxGE84VuWlwCvcVnf7nJxhP0QleHCeDTvKrtxrsMgoYuOF
         kDZLL2sayd/5t5R9acyu6XvmItP8S1qVb/Bt2ASf0NreqPbGiP2+Bf8vrBsh+jEU1fjx
         +qtjuHxJ0Gt8YOc9IBxs90thx2hzYPACPL2B4PxyYGKpg9xDU17NJ/CTnGpLHudFvLRP
         rrKoGI2GXPEguXxyjqLD6MEba3KU7u/9grzgSQtfc0tspsiFpriTKHbqYydWiGeDgjV+
         dl+g==
X-Forwarded-Encrypted: i=1; AKwUvBw09521Dg49LmEKq68F1OvNQy0n3FOx+ltjMueLertN43fqFcQZsXVRa739cLbN3cG3LumO2eleuqM=@lists.linux.dev
X-Gm-Message-State: AFq9FYJngbMDvEaFpmcDD5trxpSReN5saKjJ1VWpfFQYv/Mzk3AMVez3
	AkWc7LbKJqJZHd4n79uifmUGq4mmgZLDkLqxcjaydmhteMNTen0GUfoYzzb06ZKAuH7BDfugKNu
	bQHxl0IWiTRCeCQ==
X-Received: from wrsq4.prod.google.com ([2002:adf:fec4:0:b0:48b:d675:3474])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:400c:b0:488:894d:20b0 with SMTP id ffacd0b85a97d-48c4731c267mr3325758f8f.44.1791027529399;
 Sat, 03 Oct 2026 04:38:49 -0700 (PDT)
Date: Sat,  3 Oct 2026 11:38:38 +0000
In-Reply-To: <86a16fc6ea0a57cea7459ac2ebfdfc1b@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261002205242.3820674-1-jpiecuch@google.com> <86a16fc6ea0a57cea7459ac2ebfdfc1b@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003113843.17313-1-jpiecuch@google.com>
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Generate qseq from a
 per-task counter
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Fri, Oct 02, 2026 at 12:33:27PM -1000, Tejun Heo wrote:
> Maybe wrap the counter where the QSEQ field wraps instead of looping?
>
> 	p->scx.ops_qseq = ((p->scx.ops_qseq + 1) &
> 			   (SCX_OPSS_QSEQ_MASK >> SCX_OPSS_QSEQ_SHIFT)) ?: 1;
> 	qseq = (unsigned long)p->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT;
>
> On 32bit, the shift drops the top two bits of the counter, so the mask is
> what keeps the counter from reaching a value that shifts to 0.

Sounds good, will send a v2 with this change.

Thanks,
Kuba
