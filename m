Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049AA33343B
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457860; cv=none; b=AYkiEfc0h4QxXoZ+Jg40RHBTSGDl4iCRgpol/De8MjuKeTnl2nfwdFkVcnUpTwbxmttf7X4IbPPwX4TUOSDGB0apf8IIb5z/fiPl9DuTdE47jjSY/2awN9fqiV4/J5bgDn6Rzhq62+Iv6O72OEYua95JbB7/HzDzgzIYiBC1V/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457860; c=relaxed/simple;
	bh=bZRMY4c+6Aw9HI2WphyPhxdANeA1VWP7OAMV5JZllZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M9tfWlkwb/h6OqRYilPANZwxn7qCr31NolJ0+CGdSzVZVkElg1zI7NGjrfrCMY/+fKMaXdwW27X7C5o0ofSsxN5IoKvWEAR3iOy0rKXCrwuvwuTFJCf2BcCheE5wySCtKsi74z6TjayMy9PnAuqVdCZTVkl1tyb+4JJlXD+FX6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxxHiFPq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxxHiFPq"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4411a1f9601so8516870f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777457857; x=1778062657; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bZRMY4c+6Aw9HI2WphyPhxdANeA1VWP7OAMV5JZllZE=;
        b=CxxHiFPqUfNz5U7qLD8tuSLXmOL0ib9GgwFE9ftp4Lr1eoipRAnF27bh17aJ0V5MCd
         sW+MrFYC95d+3iB6i6Qb9QYZzWj8+LPzcGf4kj/lopekI2qEMSxCMWjCwW9iJ+6sazGM
         QA4pHmOZL0S20vXUDgqC0M+8b2M+B1+W7XQ9+ZB/zSjqp2rk6timH/ZxIL0HV/KKsxth
         7bvnVlkiVmBy1v1PhSqHokmi0CbTMJTvMjok96dHoFNM544Z+9AKVDiSpy+oNf8z+woc
         bTN3iN4G+HpcEhac91vFat2SOJPjT72AU3l28KPogFq1tHywqoYRzZeSc0bhm65qmYzI
         uehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777457857; x=1778062657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZRMY4c+6Aw9HI2WphyPhxdANeA1VWP7OAMV5JZllZE=;
        b=q7dfMgF8PrXT903AZOoUbre9S+zlmPmIO493Y5iijXNLd85fNOmYF7w0nSVDTos0tD
         WolfkFfv1uxarCf+QsZtPhXaWAowscOdXm4WAFZ7qWZu461KUIQz3YE6hrFZPDsiFWXn
         Ebhfx98t7keAzutMOGg2+MaP/tsOmLtMueJ6wBQ/0fHgPoCYprpZ+fEpEncqNXgIq/+b
         ub5WbO4V68+JJ+u/m/jwET9ojmiAf3YfvVbq3geD/51fkU1VvdMhYFKCQevorY+JZWTN
         R32E/KhtzI71IWj79H1uG+rE6b13Rs7Oma39JsN7ANs7s2Gw/TZRLfLnWfuWvHkLcL50
         RDPQ==
X-Forwarded-Encrypted: i=1; AFNElJ87oqEZX6DDF5lyFhVxk2ph2bwDfAcFgYeyceB61ytutf416SL+HBq6TC2iHHqk/XWFIM4QDhrxf5k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxEQzkUMJ6B+EjW/7FRlm2jmV1lqHvRHRALxw3onARXkB47tuk3
	uCzkHBoLkHWlDqS96O+QVpG1a49F38DDABlpV6Q3xC8DkE9AieL0Ijb+9+5DkafID98w2QEHcCB
	OQG7dK1ima3zlug==
X-Received: from wrbdo12.prod.google.com ([2002:a05:6000:c4c:b0:43d:785e:4f79])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c10:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-4464b86e789mr12343722f8f.42.1777457857036;
 Wed, 29 Apr 2026 03:17:37 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:17:36 +0000
In-Reply-To: <afEUFzbBUXjCMTGQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260424172721.3458520-1-tj@kernel.org> <20260424172721.3458520-8-tj@kernel.org>
 <DI4T25FH7PEY.1VCTSR0XNJW7M@google.com> <afEUFzbBUXjCMTGQ@slm.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI5K82LM3H7R.2QLURK950Y0V9@google.com>
Subject: Re: [PATCH 07/17] sched_ext: Add topological CPU IDs (cids)
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, <emil@etsalapatis.com>, 
	<linux-kernel@vger.kernel.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Zhao Mengmeng <zhaomzhao@126.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Tue Apr 28, 2026 at 8:09 PM UTC, Tejun Heo wrote:
> I submitted a PR to make it send review emails but that didn't seem to have
> worked. If you look into how to make it send review emails, I'd appreciate
> it.

Hm, I don't see any PRs like that under https://github.com/sashiko-dev/sashiko.
I sent one out myself: https://github.com/sashiko-dev/sashiko/pull/136

Thanks,
Kuba
