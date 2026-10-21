Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571929;
	b=eXCUkFT1uO3g9mvEJOQAXeawO+ep1Wiv2y454a4qcnuHflgU2YJzE6cRPHb9yXFEfLbG
	 s9G60AJdbaPFxBwUVBl6YCe3H0lf8hmLl47fLR+NweIomUtACHertnlqPNbIWIy2cHnKW
	 SdWQkXCreTv2lvv+ANLs2B4WH3WbJTpQ6sGlTeDkbTUmESPhOaHUEKOORoLm0YezfPMVD
	 WXZtMeKFyVsDrL6102IegB37TuMukCLk0F2jxZgC0+Gn1P7e8EEzeS8VjCWsaBIHr1Iz8
	 lRBbY80FbwpSlPkebqfZibFtxEbyuXjU57uxVllEXXKGn5BWVAiGavsLk+qP75YrqRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571929;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=4BeR0d2NBo7TTv1s4Fw/XPHIiIsyxioSWIUyXbU3ce0=;
	b=yS9FGrXO+Is3w0IlY5QIAzitSqolNt/obh1YpWqPXAH8AcFxhE3wN2znAdir5pwEFxl8
	 wkWETA33ToMGHKtHwqpoBtO4nThflejJqgIcMqvJ0ZC2IvJPHEKJAmj9qsACF1NMfM1br
	 XeQG44s11WwhzmNP/NTHOD3dcSM9y02EQyG/iEKVj1DrdQJI9FHYqpad67wz7oWwcg/iu
	 WHXsnnMbmtte1SKRKwGcc6gv4/DS7bRkKirsqE/KDHaa+Wu0IrcNTWCrleekoh/PQVnjo
	 Wjm6J+K0wlIQ4uOTswwwpMfaaDOY5BL9/BO6oXoIVAgxBkhOf3a9FGgimCPLjNMKWvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=loD5EpsV;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F1606A31A
	for <sched-ext@lists.linux.dev>; Wed, 21 Oct 2026 08:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D1F1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=loD5EpsV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=4BeR0d2NBo7TTv1s4Fw/XPHIiIsyxioSWIUyXbU3ce0=;
	b=loD5EpsVw8UguaXWl8DEYSFgoJa0cSCEKntETTanb5XGNPleeGygEZFIpgJKto
	MPCgJ7Zrm6nbOEVhEcBkq3G3BEgCjkB9P+EV5hJcqmz9jjQStQNjsoMPerG7b0o1
	H+4W55JKJfW+KZLHXNb2O9SNfaB1KnUyPC6bspY7/VsxQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3fwoCethqVCE7Bw--.20192S2;
	Wed, 21 Oct 2026 16:38:26 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: Re: [PATCH] sched_ext: Reject oversized automatic CID shards
Date: Wed, 21 Oct 2026 17:36:38 +0900
Message-ID: <20261021173638.1658294-798632-sh_def@163.com>
In-Reply-To: <aths_re-QX5Er4Vq@gpd4>
References: <20261021064946.1445728-1-sh_def@163.com> <aths_re-QX5Er4Vq@gpd4>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fwoCethqVCE7Bw--.20192S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUeksDDUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QNvzmrYegPDnQAA3e

> However, the only thing reported is "scx_root_enable() failed (-7)",
> which doesn't say much about what went wrong. Can we report the reason
> with scx_error(), similar to what scx_bpf_cid_override() does for
> oversized shards? Something like:
>
> 	if (cids_in_core > SCX_CID_SHARD_MAX_CPUS) {
> 		scx_error(sch, "core with %u cpus exceeds max shard size %d",
> 			  cids_in_core, SCX_CID_SHARD_MAX_CPUS);
> 		return -E2BIG;
> 	}

Thanks for reproducing the issue and testing the fix, Andrea!

I will send v2 with that scx_error() diagnostic.

