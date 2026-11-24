Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536957;
	b=clIWiWEypMKe8fUNrDm+sWrO2AhP2I4zc2FC8MGKjydfA9Kq9DUfPa6bnyJKb2szrYCg
	 ZnQMFd2ez5udI1OGO0iBwj5+LY3Lkf5m87DlgwW7t2tX8YIbBBqU+NEtuB5hZSkXlxqiM
	 /Msezb+xYjVs3v2yrysxAYLbGK2WZ6BDUYxOwefRppo6x7sOEnBUMZtWEe/3+9kjDHdW6
	 5D8Z3he1rbHO4vuplKGZ6De1i6BI6GmznDlysHW45KLm/wZcwDg7kyGmgQX2VxYo0yc6t
	 pD4ZurwRfPlaD2mTYU3mX+fVm9B+dxmGc2NP2mbdRPYrPsogI1drbh+ZtyiDcgcBaVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hjuDGJo5FvaUieIpfh9C53hty/r27xIyrOja0aNCv4s=;
	b=J2fr2ll5MkZQA20nE2DIYNNKlTBhlEm6R23riCsWJegx3RqTa94WpM2w3F5eH/zFnfY6
	 Q8qYBdg/vzQ+aSvLPL3Yi9h4ppuCvKgI7J2bIMyN8iqLf9wncNQp4Bqh9Rq42doHWmhMF
	 PY1HYia2E8ezLlZyR7K09OHVFid3+JqzJR2xX9NdRCyBpIdZprA90d8gj9lFNYTsLRCiA
	 flw7GZ08LOW+jVmbJhg6kAs9Rueq83+mQZRhNQ+oyrNmFRpoHXw9ehYAYZ0KpxRqLa2V0
	 NyRGyhbzI/mwE3F1exrFbwFEKX6N/i4/h4MlBgl0h7XDERmVBQmI0UKPQCLuH/dv6xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CSBjLNdA;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60434606A326
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 16:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60434606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CSBjLNdA
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38190551625so9521102eec.1
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 08:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536955; x=1796141755; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hjuDGJo5FvaUieIpfh9C53hty/r27xIyrOja0aNCv4s=;
        b=CSBjLNdA+OlIOZEsXXaXOfrXK4WhNIJPZsYCMABlv+6mvHpFGmpW5i1tufqpjmxzfV
         Cql/+W2SLgCC2n2baddW5OgV/CwPE8/jrZbHJRmSPzpt57fmUH/fzxTNH4w9/Cx0ADlg
         e3ULXVzcrKt2LDYhFDVrEQZWZmpDhIv9Th9GLHFrtraJ8BIwL1K/kY4+55usyel+aQAN
         gJBJHHfHDahMkwy1SFhlCk10Jnrxyn/B5thgJ/nX2DIMPw/ywIbTpPB8BmGbUJ8oGy4O
         Kt0xQDPU2Sb50lCMcvVVu6PmQ6FkhdCJ3zqcIRrObay3rEdw9L8vIT9k9Zvp8TcLfh6i
         A+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536955; x=1796141755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjuDGJo5FvaUieIpfh9C53hty/r27xIyrOja0aNCv4s=;
        b=j4pZT9uYW69obl0aSR+oWLT/CK1b08kNqHfVA8/o4MEZ3VPNQl6enuP6+SVPBJWm2B
         VaN7YngUpWqPwSoG02HY695toWpXtzIK++rrFSvAUY0fpI4aK+ckIb81HgPIVpgo7f/L
         +deBhppzhjY3QQCntVzM8r6cDjSVzgzvn3YNsQSAtOSJphOAswIP2y1R6L6ve4jNauhE
         4VBzxAz8Nf/Yg4uqw208XdjMIFT9zMZFLivSYTB11YlqOUoVDriftaG31/BwY+nZ7ZZh
         Fx5ehzzeIiBBbRbpQhJpCW/tbuwPZ4B1UDl0fXfQLzcLUeJ7pvSwK1YZ/XghslBMoN7r
         zKxw==
X-Forwarded-Encrypted: i=1; AL+hErFc7wI4kz5ybu/IU9dM8j7DPu7CCqadYqvVnlyK/WWuPeUw9zq4jq5rqLEFAzKLLh4VO1SpjnHN+rk=@lists.linux.dev
X-Gm-Message-State: APuU4Z8kZBGGsngzYkG6tAxw0WdpVXv5wA3ZSYoW+u1opbPa+nS5QUR9
	sTk93YUhL7pwv+cqEqbDmGa83rp7DxobJkRQpQOtPv1WUPG0H16a5Mzm
X-Gm-Gg: AZFdTZdlsIJEda3iPcJEvSA3st7kvGi70XKUVreKjwsFYn09YTiG83VJYB3chqo2t9E
	Ks3aKQg9rUxMcSb4EE/Cc0K/TUF73PWNQukYYpM+rF+9JJwLSU10wW6KyTiQ5hobgshWxKO3Vf/
	61Mcw7IbsChDgKO26pJ3FZ3zxyN9OAtiynvuBMgv5U/ugmQ2tm0D7QYkJaxt8pm8nPjfeCeHrje
	CAlWdTEEvKk87qs04KdhsbQ80fZRSIyQ/mnf2Xkt13bNGACvsD/5h1OhOUnZwXG1+dlrwRA3zt3
	LM03TkMBLYyRr5gTbSTHbL+Zsz3FQ1Z45Ht49R7CHPgztLF9nj7OYMoE5K1QhYLos2FqanJVTFP
	mVn/L1rQhODGb4u1WBxztn+Q46xcIlOl7MB6VwOPalQbJkl5nSK/x8nwVd0A5P5LjH9kWAiKotE
	P16UNrxVzkB0PgmXltys72AW7fEpQ39Qrc2g3cZPRboPx9JCyvkU/yqZc2oPqSGdrLUtHILLYqw
	sl4GTH8+Aj/yLVWjTqgRFmggKe6AZ3c9PKbN1bMIpyhXsSeh7RF42dd/a5ySpBFMndIDNSfE4CU
	I7JsYCQxv6wLuSQ05OUqhriPgG2ujILXJSVWEB1WcC4avNVb4W0mslrKBkim0wwVS2WWNyfqgBA
	HKlrCWP8Wxw==
X-Received: by 2002:a05:701b:250c:b0:1b2:557a:aa12 with SMTP id a92af1059eb24-1b5568b35b5mr13133875c88.15.1795536955278;
        Tue, 24 Nov 2026 08:15:55 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm49454679eec.14.2026.11.24.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:15:54 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: reject oversized exit_dump_len
Date: Tue, 24 Nov 2026 16:15:39 +0000
Message-ID: <20261124161543.1225966-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

When a BPF scheduler is enabled, alloc_exit_info() allocates the exit
dump buffer with kvzalloc(ops->exit_dump_len). bpf_scx_init_member()
stores exit_dump_len from the struct_ops map value without an upper
bound, so a length above INT_MAX reaches kvzalloc(), which warns and
fails, and the enable fails with -ENOMEM.

bpf_scx_init_member() already rejects oversized dispatch_max_batch and
timeout_ms values with -E2BIG. Reject an exit_dump_len above INT_MAX in
the same way, so that the map update fails before the value is used.

Fixes: 07814a9439a3 ("sched_ext: Print debug dump after an error exit")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
- Read exit_dump_len once into a local (Tejun)

v1: https://lore.kernel.org/all/20261124100508.1060692-1-rhkrqnwk98@gmail.com/

 kernel/sched/ext/ext.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..18bfb1815a4a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9220,10 +9220,14 @@ static int bpf_scx_init_member(const struct btf_type *t,
 			return -E2BIG;
 		ops->timeout_ms = *(u32 *)(udata + moff);
 		return 1;
-	case offsetof(struct sched_ext_ops, exit_dump_len):
-		ops->exit_dump_len =
-			*(u32 *)(udata + moff) ?: SCX_EXIT_DUMP_DFL_LEN;
+	case offsetof(struct sched_ext_ops, exit_dump_len): {
+		u32 dump_len = *(u32 *)(udata + moff);
+
+		if (dump_len > INT_MAX)
+			return -E2BIG;
+		ops->exit_dump_len = dump_len ?: SCX_EXIT_DUMP_DFL_LEN;
 		return 1;
+	}
 	case offsetof(struct sched_ext_ops, hotplug_seq):
 		ops->hotplug_seq = *(u64 *)(udata + moff);
 		return 1;
-- 
2.56.1

