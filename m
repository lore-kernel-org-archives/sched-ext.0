Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269CA24E4A1
	for <sched-ext@lists.linux.dev>; Sat,  3 Oct 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791029951; cv=none; b=oGnduoEVP18aig19bUD7l1I464yE4jNywyXvB27Gx/iP/vJBYP4t+bSYViMlruR3rAtK/Q5Ts0WbEdz6H9y1a6q5QjxjXQ9o+i0K0yCxjquh7h8n0CU66YpcrNVPOOoVNJVNUmPT8m+lRPa09hu9dOK2baG9sp+P9FkZA56u0jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791029951; c=relaxed/simple;
	bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=JpokhR9bod56aSNpErZN2sEnmKdRxMfllgC50dtjQe/fSkYE13QTNiq4Ybhc7fmp5pSK2/1kLmq+YH239m25uasM+CQ0oLNYeL5exph/3FaenRa6s4xfXV71Uzffd2KR23mzgIMBUdxu4slEA0F/ce84XnsxBaVdE63IzHlBuqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQS0/tR/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQS0/tR/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so166861a12.2
        for <sched-ext@lists.linux.dev>; Sat, 03 Oct 2026 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791029944; x=1791634744; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=BQS0/tR/zOYxR6OLaYuFTo2H91UB1wh6PfFN82sNc6ezFK3RX4g9ng4YIhYT4VP1D3
         qAm9LysoD1qYrG5s09PF96cbsuNjxC5SmXptdAa/fKDyLi6XO/Vdvn/1Sh3bJ+DBU2BJ
         n/rGlLO8w4sBkDmkJknoWMrvQqqmczmHhJ+F8Ib1XNo0gdFPfun9TTsER+Ek6dflkt+2
         yUF3SNkjVlI5/Wapmiy1ps2xLnJdWSsCmI8MFiyUjurgt/jx4MYlVCW10Xq2FC2dOyWL
         B6culDbI5ePuK2XLn7MuONQrgIj4OhJG8/AoDdtOtwKCIs+431R4ZAtgKmNzbbylqWPY
         c2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791029944; x=1791634744;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0/7vUbzZ2WS3ekKYc+/9kx/XXTqOYvzaiHvHZHSBnk=;
        b=Puq5/ai0J11P5QADPyvb1DKHBeAyITcRV45TpdMCNJmoIvfZIcd8/mq52zfQtN1i6j
         qVT7aa55SKInJ8Gt+llrEtmyIGt/nJPGZWIvzkqycs4fvNgefAE5De82Nor0v2jA5cdf
         c5SdLseSLara1weMi5Sq57B9VbyU+hZOXQuresImIjAXb2O4akGzWPKuTikGep3uzPDy
         6uV4wksvjC0igsTu/DwAHlDbyz64Bf5Ct560xqJEs4vNPVd9XZUXn5P4cBzNXeJDLI00
         4HtO8VqeUvcyItYPRFCaczaM6WMdzevkyb1o6+yfEaeFSMCcz7mB/3v2LEgmYyh9JTjG
         w1wQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9LssBu0eVVUaYyIv3AkyBEiXBvkhduA84/HU/Iif0GgkWMsECQpOzi2+n2Tzs9/avby/kFbv7W6Y=@lists.linux.dev
X-Gm-Message-State: AFuF++nTyTDo2p7zs1OMszPIrw5bViUug4mXLh4KRdkqkCGNTJqhXMAS
	D03RRNE2eVcFvebJ9nvLV9fGKr0WdFhrx/sWM89uRqLxI8/bnRPHCyQ/
X-Gm-Gg: AYBFou3MguA/LOycGY+o18ocYCYvQQDLFT8QYP4dK/mWswbXrW5nmUsoXQrzjghQn8O
	PDq4u1MTCEviEJOpxY+DQOPcyCkzKlO4tNWLecAjejz5IxOUyWjcQZVpq5cIFmVe+Me7N8+enL2
	bwteUNoq52HvKgyYLOq8OxvHJakYaLQfS8WQzENlRnRcZJKy8kbX4uTO95IE+l9Q5ypmJFl5Bsa
	ygn9KaVKyI8pdNLqeZcLcEvnOQmHbxxuO1aaga451IxL4eDZewTU1CwKOkWf88fx4pBGOQgsVgm
	HmqOYiNQsCDKYeU1KE8ryVoeel4vPz58RNU1m7y05xhmR5QK1XpYDYza3yc2zLRH3dCL38CBjQ9
	xr16hAFr+RNp9tdHFhrzI0tp1AC/pFQpNgTTdpw0/w6kLiaa+InKenAr3AxSdP8lA7wqEacs5gt
	g4g0qxBJjhH2gZqrHpGluInQSL2CXbWaeeNP2O2d08VhlwtiuuHui03f+MStx8Dg6vul5/oRQ2r
	r/3H6aq5kPBtqhy9CdOoyR+NXmpcBWpinTFvcPGt3cloYLKnixRiC79b8/2E38AG6yuOGZ0duuE
	wQ8=
X-Received: by 2002:a05:6a21:d89:b0:3dd:a197:7360 with SMTP id adf61e73a8af0-3e0d6d8ff80mr2052536637.57.1791029943830;
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cca561e9d1dsm1740373a12.6.2026.10.03.05.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 05:19:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 12:19:02 +0000
Message-Id: <DLV74KRI1SBL.MYZVQAB3N6QG@gmail.com>
Cc: <abuehaze@amazon.com>, <acme@kernel.org>, <andrii@kernel.org>,
 <arighi@nvidia.com>, <arnd@arndb.de>, <bentiss@kernel.org>,
 <bpf@vger.kernel.org>, <changwoo@igalia.com>, <christian@heusel.eu>,
 <daniel@iogearbox.net>, <doebel@amazon.de>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <irogers@google.com>,
 <jay.wang.upstream@gmail.com>, <jikos@kernel.org>, <jolsa@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux@weissschuh.net>, <martin.lau@linux.dev>,
 <mathieu.desnoyers@efficios.com>, <mcgrof@kernel.org>, <memxor@gmail.com>,
 <mhiramat@kernel.org>, <mpohlack@amazon.de>, <namhyung@kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <ojeda@kernel.org>,
 <petr.pavlu@suse.com>, <qmo@kernel.org>, <rostedt@goodmis.org>,
 <rust-for-linux@vger.kernel.org>, <samitolvanen@google.com>,
 <sched-ext@lists.linux.dev>, <shuah@kernel.org>, <tj@kernel.org>,
 <void@manifault.com>, <wanjay@amazon.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 00/12] bpf: make the vmlinux BTF an
 on-demand loadable module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>
In-Reply-To: <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
References: <DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com> <7fe71959-1c58-4b6f-9019-6f886683530e@oracle.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Sat, Oct 03, 2026 at 12:45 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> The only overall cost is if when we wind up using vmlinux BTF with the compressed
> .BTF section, since we have to do a full vmlinux BTF allocation (on top of the
> spac taken up by the compressed .BTF section) right? So slight penalty if vmlinux
> is used, but big gain if not.

I think it can be copied compressed into vmalloc area and
freed after decompress, so memory usage should be exactly the same.
