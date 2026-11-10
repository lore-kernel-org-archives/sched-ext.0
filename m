Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315055;
	b=wfwuV22pD9cZuL/1/Nfk/h56JQWUgconqnRe2Z+VVdibIEbzZOyq9PoiyxdKPfY7h5Je
	 7FxvwjLs1/d6mKPJMAOgfF6wvs5Z0LL6eV2tRd1L9NPgH2+BvIUgKaWlniN0pVFM2M7Tm
	 BRzAJfqBvL8amgGOCGSnxCKWo7IWj4OvaeEjIybNDm1ZjCcmxY7O/toMY/TnYr9KzaHR0
	 HhYj6BuojhMHxuLF4sOuj0FIJHH5ooHLDpaWpWjRPYiIlB4F48o0Qvofr9oBnTIKQB/Re
	 7GaASRBaULlg3Q4TGridzOFKiFqGifK9XgniKR6qqFyuw8TFTGI1YFNloXdR0tAu9jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315055;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JqXiUKs5xunEl31xUYALni/1QyfIISL1eBxWiwiWH30=;
	b=jFTLO4ByVJS0vhY4FQg2dmzmxstYjjiIMz4CrmEPTG5HRGAO+0mlgxlFILCEIOIw7+gr
	 2kZ03BCCxgS67grrrWK3g5vCur0/rCg+UXOeZPZjaAQG1+ipU6I4Jo6i+aPNulyLSmdDc
	 Ba+18VcPgf5ypzgFv5+joFUGLUJyttqwsPyjznrg2f/W7keaVstjQb/eqTs4dpqx2pRkq
	 g/3SX5dPTTeUoWGykAotc6+IgTNX8nwE74oO1gX7icioUPp1q8nHquFS5QxyXm1dpnBWi
	 l+J3A5bGc473OVtJxPTcR+EMjZmouSEyOFbaw9bujrJB605CAoncx+M4GFVb8rB08uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qcdZfq6E;
	arc=none smtp.remote-ip=95.215.58.91
Received: from mta1.migadu.com (out-91.mta1.migadu.com [95.215.58.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28E606A332
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E28E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qcdZfq6E
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6hiWiOyIu+LHqUNivb0i4YRtYJKUmtW8lpp6XsqXing=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315052; v=1; x=1794919852;
 b=qcdZfq6EG7aERpqoy4mpB94kLhY8jjW7FhLOil0+gCfBTz4IfjFK1lBSgpr75uSwqV2TheRr
 tR+I5FOR8krZ3PxdkuYsg/1JTFs01+vtgRLrTyJzHk2zbWkmQOw51Vu5UeG8yaDdxUTzqMYr07w
 SG8FWtWyEfC4lz1SLl71K04U=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 865760993d19670e;
	Tue, 10 Nov 2026 12:50:52 +0000
X-Mizu-Trace-ID: 865760993d19670e
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	devnexen@gmail.com,
	zhaomengmeng@kylinos.cn,
	emil@etsalapatis.com,
	yphbchou0911@gmail.com,
	mingo@redhat.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/9] tools/sched_ext: scx_flatcg: Validate the stats interval
Date: Tue, 10 Nov 2026 20:49:54 +0800
Message-ID: <20261110125001.4167503-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125001.4167503-1-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

The interval is parsed with strtod() and split into a timespec with a
float cast in the middle: a negative value produces a negative tv_sec
or tv_nsec (for -0.5 the seconds truncate to zero and the nanoseconds
go negative), and any value that doesn't survive the float round-trip
(e.g. 2^24 + 1) produces tv_nsec >= 1e9. Either way nanosleep()
returns EINVAL, which is never checked, and the stats loop starts
busy-spinning at 100% CPU instead of sampling at the requested
interval.

Reject negative intervals up front and compute the nsec part from the
double rather than through a float so the rounding hole is gone.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index 4c3c2cca2b85..bac6535fa2f0 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -158,8 +158,12 @@ int main(int argc, char **argv)
 			break;
 		case 'i':
 			v = strtod(optarg, NULL);
+			if (!(v >= 0) || v >= 1e18) {
+				fprintf(stderr, "Invalid interval %f\n", v);
+				exit(1);
+			}
 			intv_ts.tv_sec = v;
-			intv_ts.tv_nsec = (v - (float)intv_ts.tv_sec) * 1000000000;
+			intv_ts.tv_nsec = (v - intv_ts.tv_sec) * 1000000000;
 			break;
 		case 'f':
 			skel->rodata->fifo_sched = true;
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
