Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225550B437
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778459; cv=none; b=MPLYrdV8+7XPTjMD0GW6AEwZeAMggjZniMT4FMWE9ETxOEHYprcDSPPo5bX4aH2l2Re5eyJKzUVdbRaD/D7En4zUWlczfKYNppEfa/QP7JRirjJQrMfqn3+fFQkUHdSCx/qVraKR4uNZ0N7j5yZnxSwvsi7nrEJw2wRNRBksiRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778459; c=relaxed/simple;
	bh=N9+/8jM8uuYfmpUXLuAXawQmfXgOP7OdkrV1C2ve3fQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLNVGgqVsYCsUOWITSL9T+3Fvh/SWtIj1g3OzBOUsOTJrYYj9WD34wcW5h8oDNqmtd73h1DmoeFuCZbxLNGScZo7ZGfY7JrfYk2EZ9HjXv+dVqviDH1v8d9l68LPSlv/B3RkBSQTeHNPw/ejwxKd7qc0C1EKUS1hyzN3f64r0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSIZD4yC; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSIZD4yC"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e745d5dabso50249935e9.0
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790778447; x=1791383247; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQ9BCMyvbPVlkBm+1l1uCAim/rVq0Tdr7btP51j5V+c=;
        b=hSIZD4yC2dI26scCayYaPrcBE2GVIMjdangMi+m7lccKtPxxcfrEjOAcSc5PWpzoTR
         xBy/7LlwarEHutCQuM1fD/kezHd6/hyc1HcxSEOpAXJkUIxpm5LEPDUf4wotuQrmcr41
         oSNqipnyTqmnXzzD8dX2rjOZYPvPgwnpuVHquER8T8JUrAqkePYDS0QF7xVPe0qOqtoG
         c8zwwW6a8SXywD/rjfbJ9pWXvmHMzuZ57tL8+XnZwcIdi2ZKMSN7P2s+ravHM9gv5uRy
         MsuZe6HTvSHh8lMK/tD7pZTv1JcWbzgS68rg5VV1lSw4aSqhrpiqYTxssh847qjwMkoH
         XkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778447; x=1791383247;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQ9BCMyvbPVlkBm+1l1uCAim/rVq0Tdr7btP51j5V+c=;
        b=Xt77S88ZDqVsDh2QHLUY2hhfI0/xg8dvUBsqtnTnaGY/PBUGReJDvg3wvLv+namk9z
         Dth9FPZUBfM6HUCwWTfecvnVmYlaUP0Y6e9Vqtp/tCYsy/l5O27JC1EI8UPcp0RFMrGu
         UdlzMYOmFd2oWzN7sVhzudu7H3EW6g7oolGbYpHiRCISJ+Ir4vOuQB8lMa/4QEK2PAot
         RjU+NFHgd3B0vXMX0bBIn189Vaev8C1y+QsKajgDFKQQhE+4AYlKhmZZ9tMYXRSStAiD
         IS5luldd3WJ9gUcneFIntR4Ddc57dnPLHZTOv5UA2kEKo4eLRVxnPQMgCpVNETRejELl
         tSkw==
X-Forwarded-Encrypted: i=1; AKwUvBy/ELKHiu4Jhy1t+uxEBIWqomKFy3XHhhQ46RjKIVzu5TX3MqLIYrv4VaXt9QdfX+GegbUbDwYWbdU=@lists.linux.dev
X-Gm-Message-State: AFuF++nw8/8u1FOgQvE3Xu5zo4smcrb8zR4cr6PoOzVr82KTBkZZr+CW
	cY3CDAwvOGzSapi1ipyOXDbyINLlU7CJLwK4lNwsj6/jHYZ96JUaqQXLCOzRtHBl1d02OrA3ck4
	ahEcsBKUjfzFuOw==
X-Received: from wmde11.prod.google.com ([2002:a05:600c:108b:b0:4a0:1d42:115f])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c3cd:10b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a01b131337mr21208985e9.31.1790778447237;
 Wed, 30 Sep 2026 07:27:27 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:27:04 +0000
In-Reply-To: <ar0Ua_zkwY7P22iI@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260930114725.331370-1-jpiecuch@google.com> <20260930114725.331370-3-jpiecuch@google.com>
 <ar0Ua_zkwY7P22iI@gpd4>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930142706.560608-1-jpiecuch@google.com>
Subject: Re: [PATCH v2 2/2] selftests/sched_ext: Add a test for ops.dequeue()
 on remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrea,

On Wed, Sep 30, 2026 at 03:53:47PM +0200, Andrea Righi wrote:
> If there are MAX_DISPATCH_POPS or more stale entries in front of a valid one, we
> return without dispatching anything and the CPU goes idle. It's quite unlikely,
> but maybe we could re-kick this CPU when the loop runs out of pops while the
> queue is still non-empty to make the test a bit more robust?

Good idea. v3 uses bpf_map_peek_elem() to check the queue and kicks the CPU
if the queue is not empty.

> Nit: maybe reset enqueue_seq as well?

Done.

> Nit: uei isn't reset between scenarios, so in theory this check in the
> second scenario could pass using the exit record of the first one. So maybe we
> should add:
> 
>     memset(&skel->data->uei, 0, sizeof(skel->data->uei));

Good catch, done.

> Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks for the review! I've added your tag in v3.

Thanks,
Kuba
