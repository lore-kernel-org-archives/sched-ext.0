Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CA279324
	for <sched-ext@lists.linux.dev>; Tue, 23 Dec 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766495909; cv=none; b=IuwUH/qChuj2n0XfccWBiM4mo71KWEpgqBxG5TqXuCgp4unF3KvQWR4d9dVFaV6pqqMnq5OC/PJ7ECX9ipwvgmcY3GfGyOB0EMi+PQRJdzvVKGPLINZwVYyh/XYu/CsMp2A+hJy7J5sYtUkthPwQj5ScaiBg08o+URPTzPCxW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766495909; c=relaxed/simple;
	bh=EX3Q1iOI86GxqfWAsNE/v+tKG6nUCZnjA7F3B63iTss=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=hfLOhwWEzLKmR+hLdaHE8MVZuT+MoSIvwle9FfXg7EsYiN9XX41q3FdoVjVvrMqiFPZLKfgHysJerdqqGlgfXODKnTSv8bz0k+//dL7nUom9zxo2vVJi4K4+7ulCNyyZNq63vPlFA1PaUBraypSoQ4mLuGEAjo+0JQ2KgL7PLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=twoM49fD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="twoM49fD"
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766495906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EX3Q1iOI86GxqfWAsNE/v+tKG6nUCZnjA7F3B63iTss=;
	b=twoM49fDamLvYOttGkR1gChdse3P9dIY+FKerhjoVtq4sv1dQVCrt1jd/vMhAxajKOmDCt
	MjXR+veQ5LEC44ErbYMKiJPcNs5fQYCpxvXrAZraT2/zE5hVikGxYjWlatFFhVhJRVXTZu
	vjR0lCNzAxnNucKq99Wywtlfs3j60WY=
Date: Tue, 23 Dec 2025 13:18:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <62a69ff5257a46852275618d3be8e25fabf0a116@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] sched_ext: Avoid multiple irq_work_queue() calls in
 destroy_dsq()
To: "Tejun Heo" <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 emil@etsalapatis.com
In-Reply-To: <682c3b7818107ce0e757b51bdb17b955@kernel.org>
References: <20251222115318.18997-2-qiang.zhang@linux.dev>
 <682c3b7818107ce0e757b51bdb17b955@kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20Applied to sched_ext/for-6.20.
>=20
>=20Note: Commit message updated per Andrea's suggestion.

Thank you for update commit message.

Thanks
Zqiang

>=20
>=20Thanks.
> --
> tejun
>
